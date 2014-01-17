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
    @background = "ocean"

    respond_to do |format|
      format.html { render :index }
      format.json { respond_with(@messages) }
    end
  end


  def sent
    @messages = current_user.sent

    respond_with(@messages)
  end

  def favorites
    @messages = current_user.favorites

    respond_with(@messages)
  end

  def trash
    @messages = current_user.trash

    respond_with(@messages)
  end
  
  def search 
    @messages = current_user.search(params[:search])
    
    respond_with(@messages)
  end
end
