Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  root :to => 'user_sessions#new'

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :articles do
    resources :article_versions
    put :edit_version
  end

  resources :agreements, param: :pid

  resources :groups do
    post :staff
  end

  resource :pending_agreements_report, only: [:show]
end
