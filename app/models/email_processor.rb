class EmailProcessor < ApplicationController # to add the logger
  def self.process(email)
    puts "--------------------started from the bottom now we here!"
    puts "class = #{email.to.class} "
    puts "email_addresses = #{email.to} "

    recipients = parse_recipients(email)
    puts "recipients: #{recipients}"

    message = Message.new({
      body: email.raw_body,
      sender: email.from ,
      draft: false,
      subject: email.subject,
      recipient_emails: parse_recipients(email)
    })

    create_recipients!(parsed_emails)

    render status: 420 unless message.save

  end

  def parse_recipients(email)
    email.to.class == Array ? email.to.first.strip : email.to.strip
  end
end

