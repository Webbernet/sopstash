Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  root :to => 'user_sessions#new'

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :articles, only: %i[index new create show edit destroy] do
    resources :article_versions
  end

  resources :agreements, param: :pid
end
