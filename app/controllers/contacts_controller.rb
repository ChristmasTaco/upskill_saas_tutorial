class ContactsController < ApplicationController
    def new
        # This code is run when the /contacts/new page is loaded
        # Creating a new instance variable for each user's information in the system's memory, to be used later
        # The form needs to identify all the fields as an object even before it has to use them - preparing a blank object
        @contact = Contact.new
    end
    
    def create
        # updating the @contact instance variable with the entered parameters (each user's information) to be saved to the db
        # 'contact_params' is a method that is called (outlined below) that says that we will securely save the entered data into the db
        @contact = Contact.new(contact_params)
        if @contact.save
            # In order to send the ContactMailer email, we need to lift the parameter values for our instance variables from the params hash
            # From the private function below, we are grabbing :name, :email, and :comments (renamed to body) from the :contact KEY to use in our 'contact_email' method
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            
            # Calls the 'contact_email' method from the contact_mailer.rb file with the above variables, and .deliver it
            ContactMailer.contact_email(name, email, body).deliver
            
            # Setting a specific message (flash) when the submission was successful
            flash[:success] = ["Submission Successful"]
            redirect_to new_contact_path
        else
            # Setting up the flash to show any errors that are incurred by concatenating them with a ', '
            # 'errors' method generates raw errors to be displayed when the '@contact.save' method was not successful
            # 'full_messages' method creates nice error messages from the raw 'errors' method that can then be joined
            flash[:danger] = @contact.errors.full_messages
            redirect_to new_contact_path
        end
    end
    
    private
        # Creating a private method to ensure that all of the required parameters are sent when hitting submit
        # This private method can only be used inside of this file
        def contact_params
            # Whitelisting all of the parameters
            params.require(:contact).permit(:name, :email, :comments) 
        end
end