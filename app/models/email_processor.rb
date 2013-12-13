
class EmailProcessor < ActiveRecord::Base # to add the logger
  def self.process(email)
    logger.debug "--------------------started from the bottom now we here!"
 message = Message.new({
      body: email.raw_body,
      sender: email.from ,
      draft: false,
      subject: email.subject,
      recipient_emails: email.to
    })

    logger.debug "--------------------we made it this far!"
    message.save
    logger.debug "--------------------by now we might have an email!"
  end

end

# :body, :draft, :sender, :sender_id, :subject, :recipient_emails