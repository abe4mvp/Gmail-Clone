class MessageFlags < ActiveRecord::Base
  attr_accessible :message_id, :read, :starred, :trashed, :user_id

  belongs_to :message, inverse_of: :message_flags
  belongs_to :user
end
