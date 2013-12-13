class Message < ActiveRecord::Base
  attr_accessible :body, :draft, :sender, :sender_id, :subject, :starred, :recipient_emails
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
  #
  # has_many(
  #   :message_flags,
  #   class_name: :message_flags
  #   inverse_of: :message
  # )




end
