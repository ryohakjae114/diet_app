Rails.application.routes.draw do
  resources :recipes
  resources :items
  root "static_pages#top"

  devise_for :admins, controllers: {
                        sessions: "admins/sessions",
                        registrations: "admins/registrations",
                      }

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
                                            sessions: "api/v1/auth/sessions",
                                            registrations: "api/v1/auth/registrations",
                                          }
    end
  end
end
