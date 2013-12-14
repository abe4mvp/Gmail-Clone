module MessagesHelper

  def imply_sender
    params[:message][:sender_id] = current_user.id
    params[:message][:sender] = current_user.email
  end

  # def parse_emails_from_incoming
  #   @message.recipient_emails.split(";").map(&:strip)
  #   #.keep_if(valid_email?)
  # end
  # # refactor and use a prc? or lambda
  # def parse_emails_for_outgoing
  #   params[:recipient_emails].split(";").map(&:strip)
  #   #.keep_if(valid_email?)
  # end


  #depracted
  # def create_recipients!(message, parsed_emails)
 #    parsed_emails.each do |email|
 #      message.recipients.new(email_address: email)
 #    end
 #  end


  def create_sender_flags!
    @message.message_flags.new(user_id: current_user.id)
  end



end
