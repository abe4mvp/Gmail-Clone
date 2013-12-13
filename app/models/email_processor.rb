
class EmailProcessor
  def self.process(email)

    logger.debug "X-----------------------------------X" + email

    message = Message.new({
      body: email.raw_body,
      sender: email.from ,
      draft: false,
      subject: email.subject,
      recipient_emails: email.to
    })



    logger.debug "X-------------------------X" + message
  end

end

# :body, :draft, :sender, :sender_id, :subject, :recipient_emails