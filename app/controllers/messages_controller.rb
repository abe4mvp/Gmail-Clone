class MessagesController < ApplicationController
  def outgoing #do this in a transaction??
    imply_sender

    @message = Message.new(params[:message])

    create_recipients!
    create_sender_flags!

    if @message.save
      redirect_to receive_messages_url
#this is only for rails, it should actually send the emails here during backbone
    else
      render json: @message.errors.full_messages #+ @message.recipients.errors.full_messages
    end
  end

  def incoming
    fail
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
