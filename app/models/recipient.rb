class Recipient < ActiveRecord::Base
  attr_accessible :email_address, :message_id, :recipient_id

  belongs_to(
    :message,
    class_name: "Message",
    foreign_key: :message_id,
    primary_key: :id,
    inverse_of: :recipients
  )

  belongs_to(
   :user,
   class_name: "User",
   foreign_key: :recipient_id,
   primary_key: :id
  )




end
