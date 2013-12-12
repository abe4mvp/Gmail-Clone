module MessagesHelper

  def new_message_with_recipients
    imply_sender

    message = Message.new(params[:message])
    params[:recipients].split(";").each do | recipient|
      message.recipients.new(email_address: recipient.strip)
    end

    message
  end

  def imply_sender
    params[:message][:sender_id] = current_user.id
    params[:message][:sender] = current_user.email
  end

end
