Rails.application.routes.draw do
  # Routes define
  scope "(:locale)", locale: /en|jp/ do
    concern :users_paginatable do
      get "(/page/:page)", action: :index, on: :collection, as: "users"
    end
    concern :posts_paginatable do
      get "(/:id/page/:page)", action: :show, on: :collection, as: "posts"
    end

    root "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users, except: :new, concerns: %i(users_paginatable posts_paginatable)
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
    resources :microposts, only: %i(create destroy)
  end
end
