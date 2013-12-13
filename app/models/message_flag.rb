class MessageFlag < ActiveRecord::Base
  attr_accessible :message_id, :read, :starred, :trashed, :user_id
end
