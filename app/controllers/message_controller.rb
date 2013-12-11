class MessageController < ApplicationController
  
  def index
    @messages = Message.all
  end
end
