class EmailProcessor < ApplicationController # to add the logger
  def self.process(email)

    #this will behave differently if recieving an email from an internal abemail user, dont want 2 copies of object
    message = Message.new({
      body: email.raw_body,
      sender: email.from ,
      draft: false,
      subject: email.subject,
      recipient_emails: email.to.join(';')
    })


    render status: 420 unless message.save

  end

end

