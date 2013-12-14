class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  attr_reader :password

  validates :password_hash, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :name, :email, :session_token, :presence => true
  validates :email, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, before: :create }

  after_initialize :ensure_session_token
  before_validation :add_extension

  has_many :message_flags

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

  def add_extension
    self.email += "@abemail.net"
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
