Rails.application.routes.draw do
    root to: 'pages#home'
    get 'about', to: 'pages#about'
    
    # Make contacts shorter rather than having to write a line for every permutation, ie get 'contacts/new'
    # Also offers a bunch of routes that can be seen using $ rails routes
    resources :contacts
end
