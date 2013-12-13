
class EmailProcessor < ActiveRecord::Base # to add the logger
  def self.process(email)
 message = Message.new({
      body: email.raw_body,
      sender: email.from ,
      draft: false,
      subject: email.subject,
      recipient_emails: email.to
    })

    logger.debug "--------------------we made it this far!"
    message.save
    logger.debug "X-----------------------------X" + message
  end

end

# :body, :draft, :sender, :sender_id, :subject, :recipient_emails