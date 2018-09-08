Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, skip: [:registrations, :passwords], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :search_keywords
  resources :tv_programs
end
