Rails.application.routes.draw do
  root "admins#top"

  # resources :recipes, shallow: true do
  #   member do
  #     resources :recipe_items, only: [:index, :new, :create, :destroy]
  #   end
  # end

  # resources :items do
  #   collection do
  #     #get  'search'
  #     post 'search'
  #   end
  # end

  devise_for :admins, controllers: {
                        sessions: "admins/sessions",
                        registrations: "admins/registrations"
                      }

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
                                            sessions: "api/v1/auth/sessions",
                                            registrations: "api/v1/auth/registrations"
                                          }

      resources :recipes, shallow: true do
        member do
          resources :recipe_items, only: [:index, :new, :create, :destroy]
        end
      end

      resources :items do
        collection do
          #get  'search'
          post 'search'
        end
      end
    end
  end
end
