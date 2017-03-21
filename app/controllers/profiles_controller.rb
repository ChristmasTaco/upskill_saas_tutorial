class ProfilesController < ApplicationController
  # GET to /users/:user_id/profile/new
  def new
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    # Grab the user from the URL params
    @user = User.find( params[ :user_id ] )
     
    # Associate the @profile variable with the user that is logged in per params
    # build_profile is a new method
    @profile = @user.build_profile( profile_params )
    
    if @profile.save
      # Generate a flash message to let the user know the save was successful
      flash[:success] = "Profile Updated!"
      redirect_to root_path
    else
      # Re-render the form to allow the user to re-submit
      render action: :new
    end
  end
  
  private
    # Creating a private method to ensure that all of the required parameters are sent when hitting submit
    # This private method can only be used inside of this file
    def profile_params
      # Whitelisting all of the parameters for security
      params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
    end
end