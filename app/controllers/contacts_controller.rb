class ContactsController < ApplicationController
    def new
        # This code is run when the /contacts/new page is loaded
        # Creating a new instance variable for each user's information in the system's memory, to be used later
        # The form needs to identify all the fields as an object even before it has to use them - preparing a blank object
        @contact = Contact.new
    end
    
    def create
        # updating the @contact instance variable with the entered parameters (each user's information) to be saved to the db
        # 'contact_params' is a function that is called (outlined below) that says that we will securely save the entered data into the db
        @contact = Contact.new(contact_params)
        if @contact.save
            redirect_to new_contact_path, notice: "Form successfully submitted!"
        else
            redirect_to new_contact_path, notice: "Error occurred. Please try again."
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