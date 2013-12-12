class Message < ActiveRecord::Base
  attr_accessible :body, :draft, :sender, :sender_id, :subject, :recipients
  # allowing :recipients here lets you created the nested model?
  attr_reader :recipients

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

  accepts_nested_attributes_for :recipients, allow_destroy: true
  #should also make methods either here or in message helper to search for and set internal recipient id

  def recipients=(email)
    internal_user = User.find_by_email(email)

    Recipient.new({
      email_address: email,
      message_id: self.id,
      recipient_id: internal_user ? internal_user.id : nil
    })
  end
  #overwrite the recipients= to take in just the email an return a recipient obj

end
