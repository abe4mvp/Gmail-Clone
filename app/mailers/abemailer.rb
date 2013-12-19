class Abemailer < ActionMailer::Base

  def outgoing(message)
    mail(
    from: message.sender,
    to: message.display_recipient_emails,
    subject: message.subject,
    body: message.body
    )
  end

end
