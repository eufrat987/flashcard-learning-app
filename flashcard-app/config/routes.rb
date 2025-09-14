Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "flashcards#index"

  get "/flashcards" => 'flashcards#all', as: :all_flashcards
  get "/users/new" => 'users#new', as: :new_user
  post "/users/create" => 'users#create', as: :create_user
  get "/flashcards/new" => 'flashcards#new', as: :new_flashcard
  get "/flashcards/:id" => 'flashcards#show', as: :show_flashcard
  post "/flashcards/create" => 'flashcards#create', as: :create_flashcard

  put "/flashcards/:id/success" => 'flashcards#success', as: :success_flashcard
  put "/flashcards/:id/fail" => 'flashcards#fail', as: :fail_flashcard
  
  delete "/flashcards/:id" => 'flashcards#delete', as: :delete_flashcard
  get "/flashcards/:id/edit" => 'flashcards#edit', as: :edit_flashcard
  put "/flashcards/:id" => 'flashcards#update', as: :update_flashcard

  put "/users/:id/session" => 'users#reset_session', as: :delete_user_session

end
