
class EmailProcessor
  def self.process(email)
    message = Message.create!({
      body: email.raw_body,
      sender: email.from ,
      draft: false,
      subject: email.subject,
      recipient_emails: email.to

    })
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXX" + email

    puts "XXXXXXXXXXXXXXXXXXXXXXXXXX" + message




  end
end

# :body, :draft, :sender, :sender_id, :subject, :recipient_emails