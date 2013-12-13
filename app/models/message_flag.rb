class MessageFlag < ActiveRecord::Base
  attr_accessible :message_id, :read, :starred, :trashed, :user_id

  belongs_to(
  :message,
  class_name: "Message",
  foreign_key: :message_id,
  primary_key: :id,
  inverse_of: :message_flags
  )

  belongs_to :user
end
