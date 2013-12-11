class Message < ActiveRecord::Base
  attr_accessible :body, :draft, :from, :to

  has_many :recipients

end
