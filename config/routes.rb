Rails.application.routes.draw do

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
  full_api = %i[ index create show update destroy ]

  namespace :api do
    namespace :v1 do
      
      resources :meals, only: [:index, :create, :show, :destroy], shallow: true do
        member do
          resources :meal_menus, only: full_api
        end
      end

      resources :exercise_records, only: [:index, :create, :show, :destroy]
      
      resources :weight_records,   only: [:index, :create, :show, :destroy]

      resources :diaries, only: full_api
      resources :posts,   only: full_api, shallow: true do
        member do
          resources :favorites, only: [ :index, :create, :show, :destroy]
        end
        member do
          resources :post_comments, only: full_api
        end
      end
      get '/posts/:id/current_user_favorite', to: 'posts#current_user_favorite?'

      resources :my_items,   only: full_api
      resources :my_recipes, only: full_api, shallow: true do
        member do
          resources :my_recipe_items, only: [:index, :create, :show, :destroy]
        end
      end

      resources :my_sets, only: full_api, shallow: true do
        member do
          resources :my_set_recipes, only: full_api
        end
      end
      
      resources :items,   only: [:index, :show]

      resources :recipes, only: [:index, :show], shallow: true do
        member do
          resources :recipe_items, only: [:index, :show]
        end
      end

      get '/items/search/:keyword',      to: 'items#search'
      get '/recipes/search/:keyword',    to: 'recipes#search'
      get '/my_items/search/:keyword',   to: 'my_items#search'
      get '/my_recipes/search/:keyword', to: 'my_recipes#search'
      get '/my_sets/search/:keyword',    to: 'my_sets#search'

      mount_devise_token_auth_for "User", at: "auth", controllers: {
                                            sessions:      "api/v1/auth/sessions",
                                            registrations: "api/v1/auth/registrations",
                                            passwords:     "api/v1/auth/passwords"
      }
      get '/users/show_me',    to: 'users#show_me'

      resources :relationships, only: [:create, :destroy]

    end
  end
end
