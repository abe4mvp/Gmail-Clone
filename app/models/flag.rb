class Flag < ActiveRecord::Base
  attr_accessible :message_id, :read, :heart, :trashed, :user_id

  belongs_to(
  :message,
  class_name: "Message",
  foreign_key: :message_id,
  primary_key: :id,
  inverse_of: :flags
  )

  belongs_to :user

  def toggle_heart
    self.heart = self.heart ? false : true
    self.save!
  end
end
