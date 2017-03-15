# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Adding details for Mailgun integration
ActionMailer::Base.smtp_settings = {
  :port           => ENV['SENDGRID_SMTP_PORT'],
  :address        => ENV['SENDGRID_SMTP_SERVER'],
  :user_name      => ENV['SENDGRID_SMTP_LOGIN'],
  :password       => ENV['SENDGRID_SMTP_PASSWORD'],
  :domain         => 'arcane-hamlet-44568.herokuapp.com',
  :authentication => :plain,
  :enable_starttls_auto => true
}