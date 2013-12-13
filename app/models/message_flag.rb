class MessageFlag < ActiveRecord::Base
  attr_accessible :message_id, :read, :starred, :trashed, :user_id

  belongs_to :message, inverse_of: :message_flag
  belongs_to :user
end
