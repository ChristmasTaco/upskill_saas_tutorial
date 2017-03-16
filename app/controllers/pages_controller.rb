class PagesController < ApplicationController
    # GET request for / (home page)
    def home
        # Creating instance variables to be used as URL parameters when linking to signup view
        @basic_plan = Plan.find(1)
        @pro_plan = Plan.find(2)
    end
    
    def about
    end
end