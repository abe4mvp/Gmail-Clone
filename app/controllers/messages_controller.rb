class MessagesController < ApplicationController
  def outgoing #do this in a transaction??
    imply_sender

    @message = Message.new(params[:message])

    create_sender_flags! # move to inside message!

    if @message.save
      redirect_to inbox_user_url(current_user) #change this
#this is only for rails, it should actually send the emails here during backbone
    else
      render json: @message.errors.full_messages
    end
  end

  def heart
    flag = Flag.find_by_user_id_and_message_id(current_user, params[:message_id])
    flag && flag.toggle_heart
    redirect_to inbox_user_url(current_user)
  end

  def show
    @message = Message.find(params[:id])
  end

  # def update
#     @message = Message.find(params[:id])
#     if @message.update_attributes(params[:message])
#       redirect_to controller: 'users', action: 'show', id: current_user.id
#     else
#       render json: @message.errors.full_messages
#     end
#   end

  # def destroy
 #    @message = Message.find(params[:id])
 #    @message && @message.delete
 #    redirect_to users_url(current_user)
 #  end
 # users cant delete messages from database, only unhide them


end
