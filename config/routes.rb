Rails.application.routes.draw do
  root to: 'sessions#menu'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/menu', to: 'sessions#menu'

  resources :users, only: [:create, :edit, :update, :destroy]
  resources :contacts
  resources :notes
  resources :events
  resources :todos do
    member do
      post :toggle
    end
  end

  get '*path' => redirect('/')
end
