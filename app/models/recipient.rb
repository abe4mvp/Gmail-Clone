class Recipient < ActiveRecord::Base
  attr_accessible :email_address, :message_id, :recipient_id
  belongs_to :message, inverse_of: :recipients
  belongs_to :user


end
