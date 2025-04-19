Rails.application.routes.draw do
  # Devise
  devise_for :users

  # Page d'accueil
  root to: "pages#home"

  # Ressources principales
  resources :tournaments do
    resources :teams, only: [:new, :create, :edit, :update, :destroy]

    member do
      post :generate_group_stage
      post :generate_quarters
    end
  end

  resources :matches, only: [:update]

  # ⚠️ Supprime les routes manuelles `get "teams/new"` etc., qui sont déjà couvertes par les resources

  # Monitoring (optionnel)
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
