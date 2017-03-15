class ContactMailer < ActionMailer::Base
    default from: 'chrislosacco13@gmail.com'
    
    # Sends an email using the name, email, and comments entered in the new contact form
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body
        mail(to: email, subject: 'Thanks for reaching out!')
    end
end

