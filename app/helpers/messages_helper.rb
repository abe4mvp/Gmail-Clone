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

  def create_receiver_flags!(message, parsed_email_addresses)
    parsed_email_addresses.each do |email|
      internal_user = User.find_by_email(email)
      if internal_user
        message.message_flags.new(user_id: internal_user.id)
      else
        message.errors += "no user found at #{email}" #does this actually do anything?
      end
    end
  end

end
