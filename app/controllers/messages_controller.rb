class MessagesController < ApplicationController
  before_filter :require_current_user!
  respond_to  :json, :html

  def outgoing #do this in a transaction??
    imply_sender

    @message = Message.new(params[:message])

    create_sender_flags! # move to inside message!

    if @message.save
      redirect_to inbox_messages_url(current_user) #change this
#this is only for rails, it should actually send the emails here during backbone
    else
      render json: @message.errors.full_messages
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def inbox
    @messages = current_user.inbox

    respond_to do |format|
      format.html { render :index }
      format.json { respond_with(@messages) }
    end
  end
  #change this later when bootstrapping

  def sent
    @messages = current_user.sent

    respond_with(@messages)
  end

  def favorited
    @messages = current_user.favorited

    respond_with(@messages)
  end

  def update


    # @message = Message.find(params[:id])
#     if @message.update_attributes(params[:message])
#       redirect_to controller: 'users', action: 'show', id: current_user.id
#     else
#       render json: @message.errors.full_messages
#     end
  end

  # def destroy
 #    @message = Message.find(params[:id])
 #    @message && @message.delete
 #    redirect_to users_url(current_user)
 #  end
 # users cant delete messages from database, only unhide them


end
