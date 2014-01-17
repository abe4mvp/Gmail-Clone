class Message < ActiveRecord::Base
  
  include PgSearch
  pg_search_scope :search_by_contents, :against => [:sender, :recipient_emails, :body, :subject]
  
  attr_accessible :body, :draft, :sender, :sender_id, :subject, :recipient_emails
  
  before_save :format_recipient_emails
  after_save :create_receiver_flags

  #after_initialize :set_internal_user_id

  has_many(
    :recipients,
    class_name: "Recipient",
    foreign_key: :message_id,
    primary_key: :id,
    inverse_of: :message
  )

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :sender_id,
    primary_key: :id
  )

  has_many(
    :flags,
    class_name: "Flag",
    foreign_key: :message_id,
    primary_key: :id,
    inverse_of: :message
  )

  def time_stamp
    self.created_at.localtime.strftime( self.created_at.localtime.today? ?  '%l:%M %p' : '%b %d' )
  end

  def sent_by?(user_id)
    self.sender_id == user_id
  end

  def preview
    self.body.squeeze.slice(0, (150 - self.subject.length))
  end

  def set_internal_user_id
    return if self.sender_id
    user = User.find_by_email(self.sender)
    user && self.sender_id = user.id
  end

  def format_recipient_emails
    self.recipient_emails.gsub!(/\s+/m, ';')
    self.recipient_emails += ';' unless self.recipient_emails.ends_with?(';')
    self.recipient_emails.prepend(';') unless self.recipient_emails.starts_with?(';')
  end

  def display_recipient_emails
    self.recipient_emails.gsub(';', ', ').slice(2..-3) # a better way to do this?
  end

  def create_receiver_flags #use a lambda here?
    self.recipient_emails.split(';').slice(1..-1).each do |email|
      internal_user = User.find_by_email(email)
      if internal_user && (internal_user.id != self.sender_id) #needs testing
        self.flags.create(user_id: internal_user.id)
      end
    end
  end

end
