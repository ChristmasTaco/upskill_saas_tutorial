class Plan < ActiveRecord::Base
    # Creates an association where each plan can have many users
    has_many :users
    
    
end