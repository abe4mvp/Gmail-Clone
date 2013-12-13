
class EmailProcessor
  def self.process(email)
    message = Message.new({
      body: email.raw_body,
      sender: email.from ,
      draft: false,
      subject: email.subject,
      recipient_emails: email.to
    })

    logger.debug "XXXXXXXXXXXXXXXXXXXXXXXXXX" + email

    logger.debug "XXXXXXXXXXXXXXXXXXXXXXXXXX" + message
  end

end

# :body, :draft, :sender, :sender_id, :subject, :recipient_emails