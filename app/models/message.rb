class Message < ActiveRecord::Base
  attr_accessible :body, :draft, :sender, :sender_id, :subject, :recipient_emails
  # allowing :recipients here lets you created the nested model?

  #after_initialize :set_internal_user_id

  ## need to remove starred
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
    :message_flags,
    class_name: "MessageFlag",
    foreign_key: :message_id,
    primary_key: :id,
    inverse_of: :message
  )

  def set_internal_user_id
    return if self.sender_id
    user = User.find_by_email(self.sender)
    user && self.sender_id = user.id
  end

  def recipient_emails=(email)
    if email.class == Array
      email.first.strip
    else
      email.first.strip
    end
  end




end
