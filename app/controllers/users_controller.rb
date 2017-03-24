class UsersController < ApplicationController
  # Lock down all user pages if not logged-in
  before_action :authenticate_user!

  # GET from /users/:id
  def show
    # Grab the 'id' value from the URL
    @user = User.find( params[ :id ] )
  end
  
  # GET from /users
  def index
    # Use .includes(:profile) to join the db tables instead of making individual
    # queries for each user.profile like we would with "User.all"
    @users = User.includes(:profile)
  end
  
end