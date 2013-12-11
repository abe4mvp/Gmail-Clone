class Abemailer < ActionMailer::Base
  default from: "test@abemail.net" # change to current user



  def send(to_email, subject, content)

    mail(to: to_email, subject: subject)
  end

end
