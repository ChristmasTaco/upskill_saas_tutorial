class ProfilesController < ApplicationController
  # GET to /users/:user_id/profile/new
  def new
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
     @profile = Profile.new(profile_params)
  end
  
  private
    # Creating a private method to ensure that all of the required parameters are sent when hitting submit
    # This private method can only be used inside of this file
    def profile_params
      # Whitelisting all of the parameters
      params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
    end
end