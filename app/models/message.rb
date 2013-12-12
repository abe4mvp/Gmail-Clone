class Message < ActiveRecord::Base
  attr_accessible :body, :draft, :sender, :sender_id, :subject, :recipients
  # allowing :recipients here lets you created the nested model?

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

end
