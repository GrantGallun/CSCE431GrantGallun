Rails.application.routes.draw do
  resources :user_books
  resources :users
  resources :books do
    # GET /books/:id/delete shows a confirmation page before the DELETE request.
    member do
      get :delete
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Home page: which users own which books.
  root "user_books#index"
end
