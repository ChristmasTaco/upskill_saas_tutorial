class ProfilesController < ApplicationController
  # Lock down all user pages if not logged-in  
  before_action :authenticate_user!
  
  # Define a method to ensure users can only edit their own profiles
  before_action :only_current_user
  
  # GET to /users/:user_id/profile/new
  def new
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    # Grab the user object from the DB using the URL params
    # User.find(1) will return the object that is stored at that location
    @user = User.find( params[ :user_id ] )
     
    # Associate the @profile variable with the user that is logged in per params
    # build_profile is a new method that is used when we have associated data
    # "build_profile" is similar to "Profile.new", but build_profile allows us 
    # to associate the Profile to that user_id when storing the data (1:1 relationship)
    # We would use @user.profile.build if it were a 1:many relationship
    @profile = @user.build_profile( profile_params )
    
    if @profile.save
      # Generate a flash message to let the user know the save was successful
      flash[:success] = "Profile Updated!"
      redirect_to user_path(id: params[:user_id])
    else
      # Re-render the form to allow the user to re-submit
      # Render does NOT make a new HTTP request, unlike "redirect_to"
      render action: :new
    end
  end
  
  # GET to /users/:user_id/profile/edit
  def edit
    # Set the user based on the user_id parameter
    @user = User.find(params[:user_id])
    # Define the form data using @profile by assigning it the value of the user's profile
    @profile = @user.profile
  end
  
  # PATCH to users/:user_id/profile
  def update
    # Retrieve user from db
    @user = User.find(params[:user_id])
    # Retrieve that user's profile
    @profile = @user.profile
    
    # Mass assign edited profile attributes from whitelisting below
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile has been updated!"
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
    end
    
  end
  
  private
    # Creating a private method to ensure that all of the required parameters are sent when hitting submit
    # This private method can only be used inside of this file
    def profile_params
      # Whitelisting all of the parameters for security
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    #Define a method to check that the user is only attempting to edit their own profile page
    def only_current_user
      # Identify the currently signed-in user
      @user = User.find(params[:user_id])
      
      # Redirect the user to the homepage unless they are the found user
      redirect_to(root_url) unless @user == current_user
    end
end