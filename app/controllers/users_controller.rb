class UsersController < ApplicationController
  # GET from /users/:id
  def show
    # Grab the 'id' value from the URL
    @user = User.find( params[ :id ] )
    
    
  end
  
end