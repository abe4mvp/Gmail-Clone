class EmailProcessor < ApplicationController # to add the logger
  def self.process(email)
    puts "--------------------started from the bottom now we here!"
    puts "class = #{email.to.class} "
    puts "email_addresses = #{email.to} "


    puts "recipients: #{recipients}"

    message = Message.create({
      body: email.raw_body,
      sender: email.from ,
      draft: false,
      subject: email.subject,
      recipient_emails: mail.to.join(';')
    })


    render status: 420 unless message.save

  end

end

