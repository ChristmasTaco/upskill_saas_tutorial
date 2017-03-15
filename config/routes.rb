Rails.application.routes.draw do
  devise_for :users
    root to: 'pages#home'
    get 'about', to: 'pages#about'
    
    # Creates all CRUD routes for Contacts rather than having to write a line for every permutation, ie get 'contacts/new'
    # Also offers a bunch of routes that can be seen using $ rails routes
    resources :contacts, only: :create
    
    # Creates a custom URL for a /contact-us page rather than having them goto /contacts/new
    # This will make the application read from the 'contacts' controller and run the 'new' action (function)
    # Adding the 'as:' allows us to keep the default path name for creating a new contact
    get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
