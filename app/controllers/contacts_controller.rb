class ContactsController < ApplicationController
    def new
        # Creating a new instance variable for each user's information
        @contact = Contact.new
    end
    
    def create
        # Creating a new instance variable for each user's information to be saved to the db
        @contact = Contact.new(contact_params)
        if @contact.save
            redirect_to new_contact_path, notice: "Form successfully submitted!"
        else
            redirect_to new_contact_path, notice: "Error occurred. Please try again."
        end
    end
    
    private
        # Creating a method to ensure that all of the required parameters are sent when hitting submit
        def contact_params
            # Whitelisting all of the parameters
            params.require(:contact).permit(:name, :email, :comments) 
        end
end