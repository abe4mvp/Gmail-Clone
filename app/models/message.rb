class Message < ActiveRecord::Base
  attr_accessible :body, :draft, :sender, :sender_id

  has_many :recipients, inverse_of: :message

  belongs_to(
    :user,
    class_name: "user",
    foreign_key: :sender_id,
    primary_key: :id
  )

end
