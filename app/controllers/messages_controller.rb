class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @message = new_message_with_recipients
    if @message.save
      redirect_to user_url(current_user)
    else
      render json: @message.errors.full_messages
      @message.recipients.errors.full_messages
    end
  end

  def show
    @message = Message.new(params[:id])
  end


end
