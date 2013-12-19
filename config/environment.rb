# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
AbeMail::Application.initialize!

if Rails.env.production?
  # only send real emails in production; use Sengrid
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => 'abe4mvp',
    :password       => ENV['SENDGRID'],
    :domain         => 'abemail.net',
    :enable_starttls_auto => true # from sendgrid website
  }
  ActionMailer::Base.delivery_method ||= :smtp
elsif Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => 'abe4mvp',
    :password       => ENV['SENDGRID'],
    :domain         => 'abemail.net',
    :enable_starttls_auto => true # from sendgrid website
  }
  ActionMailer::Base.delivery_method = :smtp
end
