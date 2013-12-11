class Message < ActiveRecord::Base
  attr_accessible :body, :draft, :from, :to
end
