Rails.application.routes.draw do
  resources :search_keywords
  root to: 'home#index'
  devise_for :users, skip: [:registrations, :passwords], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
end
