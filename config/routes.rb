Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :articles, only: %i[index new create show edit destroy] do
    resources :article_versions
  end

  resources :agreements, param: :pid
end
