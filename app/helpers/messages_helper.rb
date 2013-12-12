module MessagesHelper

  def new_message_with_recipients
    message = Message.new(params[:message])
    params[:recipients].split(";").each do | recipient|
      message.recipients.new(email_address: recipient.strip)
    end
    message
  end

end
