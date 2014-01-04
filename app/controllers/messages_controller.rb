class MessagesController < ApplicationController
  before_filter :require_current_user!
  respond_to  :json, :html


  def outgoing #do this in a transaction??
    imply_sender

    @message = Message.new(params[:message])

    @message.flags.build(user_id: current_user.id)

    if @message.save

      Abemailer.outgoing(@message).deliver! unless internal_only?

      redirect_to inbox_messages_url #update for backbone
    else
      render json: @message.errors.full_messages
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def inbox
    @messages = current_user.inbox
    @users = User.where('id != ?', current_user.id)

    respond_to do |format|
      format.html { render :index }
      format.json { respond_with(@messages) }
    end
  end


  def sent
    @messages = current_user.sent

    respond_with(@messages)
  end

  def favorited
    @messages = current_user.favorited

    respond_with(@messages)
  end

  def trash
    @messages = current_user.trash

    respond_with(@messages)
  end

#   def update
#
#
#     # @message = Message.find(params[:id])
# #    if @message.update_attributes(params[:message])
#        redirect_to controller: 'users', action: 'show', id: current_user.id
#      else
#       render json: @message.errors.full_messages
#      end
#   end

  # def destroy
 #    @message = Message.find(params[:id])
 #    @message && @message.delete
 #    redirect_to users_url(current_user)
 #  end
 # users cant delete messages from database, only unhide them


end
