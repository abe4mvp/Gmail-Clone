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
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      redirect_to users_url(current_user)
    else
      render json: @message.errors.full_messages
    end
  end

  # def destroy
 #    @message = Message.find(params[:id])
 #    @message && @message.delete
 #    redirect_to users_url(current_user)
 #  end
 # users cant delete messages from database, only unhide them


end
