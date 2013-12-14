class MessagesController < ApplicationController
  def outgoing #do this in a transaction??
    imply_sender

    # parsed_emails = parse_emails_for_outgoing
    @message = Message.new(params[:message])

    # create_recipients!(parsed_emails)
    create_sender_flags!

    if @message.save
      redirect_to user_url(current_user)
#this is only for rails, it should actually send the emails here during backbone
    else
      render json: @message.errors.full_messages + @message.recipients.errors.full_messages
    end
  end

  def incoming
    #decide what to do based on the extension of the from email
    #this is not how it will work for real messages
    @message = Message.find(params[:message])
    #replace with a create to define @message, rest of this method is dependent
    parsed_email_addresses = parse_emails_from_incoming



    create_receiver_flags!(parsed_email_addresses)

    create_recipients! unless User.find_by_email(@message.sender)
    if @message.save
      redirect_to user_url(current_user.id)
    else
      render json: @message.errors.full_messages
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      redirect_to controller: 'users', action: 'show', id: current_user.id
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
