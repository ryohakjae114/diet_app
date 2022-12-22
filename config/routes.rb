Rails.application.routes.draw do
  root "admins#top"

  #管理者機能
  namespace :admins do
    
    #ユーザの作成はseedファイルから
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

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
                                            sessions:      "api/v1/auth/sessions",
                                            registrations: "api/v1/auth/registrations",
                                            passwords:     "api/v1/auth/passwords"
                                          }
    end
  end
end
