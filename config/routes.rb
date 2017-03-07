Rails.application.routes.draw do
    root to: 'pages#home'
    get 'about', to: 'pages#about'
    
    # Make contacts more modular rather than having to write a line for every permutation, ie get 'contacts/new'
    resources :contacts
end
