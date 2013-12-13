module MessagesHelper

  def imply_sender
    params[:message][:sender_id] = current_user.id
    params[:message][:sender] = current_user.email
  end

  def parse_recipients
    @message.recipient_emails.split(";").map(&:strip)
    #.keep_if(valid_email?)
  end

  def valid_email?
    #some fancy regex
  end

  def create_recipients!
    fail
    parse_recipients.each do |recipient|
      @message.recipients.new(email_address: recipient.strip)
    end
  end

  def create_sender_flags!
    @message.message_flags.new(user_id: current_user.id)
  end

  def create_receiver_flags!(parsed_email_addresses)
    parsed_email_addresses.each do |email|
      internal_user = User.find_by_email(email)
      if internal_user
        @message.message_flags.new(user_id: internal_user.id)
      else
        @message.errors += "no user found at #{email}"
      end
    end
  end
  #
  # def send_email!
  #   parse_recipients
  # end


  # def send_internal_emails(recipients_emails)
  #
  #   #validate_email_addresses
  #   recipient_emails.each do |email_address|
  #     if email_address.ends_with?("@abemail.net")
  #       send_internal(email_address)
  #     end
  #   end
  # end

  # def send_internal(email_address)
  #   user = User.find_by_email(email_address)
  #   @message.message_flags.new(user_id: user.id)
  # end

  # def send_external(@message)
  #
  # end

end
