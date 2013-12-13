
class EmailProcessor < ActiveRecord::Base # to add the logger
  def self.process(email)

    logger.debug "-----------------------------" + email
    logger.debug "-----------------------------" + email.to_ss

    message = Message.new({
      body: email.raw_body,
      sender: email.from ,
      draft: false,
      subject: email.subject,
      recipient_emails: email.to
    })



    logger.debug "X-----------------------------X" + message
  end

end

# :body, :draft, :sender, :sender_id, :subject, :recipient_emails