class Recipient < ActiveRecord::Base
  attr_accessible :email_address, :message_id
  belongs_to :message

end
