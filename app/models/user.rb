class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  attr_reader :password

  validates :password_hash, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :name, :email, :session_token, :presence => true
  validates :email, uniqueness: true

  validates :email, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, before: :create }

  after_initialize :ensure_session_token

  before_create :downcase_email

  has_many :flags

  has_many(
    :sent_messages,
    class_name: "Message",
    foreign_key: :sender_id,
    primary_key: :id
  )

  has_many(
    :recipients,
    class_name: "Recipient",
    foreign_key: :recipient_id,
    primary_key: :id
  )

  has_many :received_messages, through: :recipients, source: :message

  def sent
    self.sent_messages.includes(:flags).merge(Flag.where(user_id: self.id)).sort_by {|m| m.created_at }
  end

  def inbox
    q_email = "%;#{self.email}%"
    sent_messages = Message.where("recipient_emails like ?", q_email)
    sent_messages.includes(:flags).merge(Flag.where(user_id: self.id)).sort_by {|m| m.created_at }
  end

  def favorited
    Message.includes(:flags).merge(Flag.where(user_id: self.id, heart: true)).sort_by {|m| m.created_at }
  end
  #save the m.created at to a prc



  def downcase_email
    self.email.downcase!
  end


  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_hash).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_hash = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

    private
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end


end
