Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :articles, only: %i[index new create show edit] do
    resources :article_versions
  end
end
