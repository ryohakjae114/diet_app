Rails.application.routes.draw do
  resources :weight_records
  root "admins#top"

  #admin
  namespace :admins do
    
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :diaries, only: :update
    resources :recipes, shallow: true do
      member do
        resources :recipe_items, only: [:index, :new, :create, :destroy]
      end
    end
    resources :items do
      collection do
        post 'search'
      end
    end
    resources :posts, only: [:index, :show, :update, :destroy]
  end

  devise_for :admins, controllers: {
                        sessions: "admins/auth/sessions",
                        registrations: "admins/auth/registrations"
  }


  #api
  namespace :api do
    namespace :v1 do

      resources :weight_records,   only: [:create, :show, :destroy]

      resources :my_items,   only: [:index, :create, :show, :update, :destroy]
      resources :my_recipes, only: [:index, :create, :show, :update, :destroy], shallow: true do
        member do
          resources :my_recipe_items, only: [:index, :create, :show, :destroy]
        end
      end

      resources :my_sets, shallow: true do
        member do
          resources :my_set_recipes
        end
      end
      
      resources :items,   only: [:index, :show]
      resources :recipes, only: [:index, :show], shallow: true do
        member do
          resources :recipe_items, only: [:index, :create, :show, :destroy]
        end
      end

      mount_devise_token_auth_for "User", at: "auth", controllers: {
                                            sessions:      "api/v1/auth/sessions",
                                            registrations: "api/v1/auth/registrations",
                                            passwords:     "api/v1/auth/passwords"
                                          }
    end
  end
end
