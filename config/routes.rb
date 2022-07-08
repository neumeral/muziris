# frozen_string_literal: true

Rails.application.routes.draw do
  comfy_route :cms_admin, path: "/cmsadmin"

  devise_for :users, path: 'auth',
                     path_names: { sign_in: 'login', sign_out: 'logout',
                                   registration: 'register', sign_up: 'signup' }
  root to: 'storefront/homes#show'

  resources :mockups, only: :index do
    collection do
      get :search
      get :category
      get :cart
    end
  end

  # Admin
  namespace :admin do
    resource :dashboard, only: :show

    resources :users do
      collection do
        get :search
      end
      member do
        get :reset_password
      end
    end

    resources :orders , only: [:index, :show, :edit, :update, :destroy] do
      collection do
        get :search
      end
      member do
        get :done_payment
      end
    end

    resources :products do
      collection do
        get :search
        get :import_csv
        get :export_csv
        post :process_csv
      end
      member do
        get :reset_password
      end
    end

    resources :address, only: [:show]

    resources :categories do
      collection do
        get :search
      end
    end

    resources :featured_products do
      collection do
        get :search
      end
    end

    resources :banner_items

    # Settings
    namespace :settings do
      resources :admin_users, only: :index
      resources :generals, only: [:index, :update] do
        collection do
          post :currency
          post :text_direction
        end
      end

      resources :tax_rates do
        collection do
          get :search
        end
      end

      resources :shipping_methods do
        collection do
          get :search
        end
      end

      resources :payment_methods do
        collection do
          get :search
        end
      end
    end

    # Reports
    namespace :reports do
      resources :sales_reports, only: :index do
        collection do
          post :sales_reports
        end
      end
      
      resources :product_reports, only: :index do
        collection do
          get :product_stocks_reports
        end
      end
    end
  end

  namespace :storefront, path: :a do
    resource :accounts, only: :show
    resources :profiles, only: [:show, :edit, :update]
    resources :registers, only: [:new, :create] do
      collection do
        get :otp
      end
    end
    resources :sessions, only: [:new, :create] do
      collection do
        get :otp
      end
    end
    resources :products, only: [:index, :show] do
      collection do
        get :search
      end
    end
    resource :home, only: :show
    resources :addresses, except: :index
    resources :orders, only: [:destroy] do
      member do
        get :add_to_cart
      end
      collection do
        get :cart
        get :remove_item
        patch :update_item
        get :confirm_order
        post :confirm_order
        get :checkout
      end
    end
    resources :categories, only: :show
    resource :offer, only: :show
    resource :static_page, only: :show do
      collection do
        get :delivery
        get :support
        get :privacy_policy
        get :terms_and_conditions
        get :faq
      end
    end

    # Payment Methods
    namespace :payment_methods do
      resources :razorpays, only: [:new, :create]
      resources :activemerchants, only: [] do
        collection do
        get :new_credit_card
        post :credit_card
        
      end
      end
    end
  end

  # Api
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show] do
        collection do
          get :search
        end
      end

      resources :users, only: [:show, :update] do
        member do
          get :reset_password
        end
        resources :addresses
      end

      resources :orders, only: [:index, :show, :update]

      resource :cart do
        member do
          post :add_item
          post :finalize
        end

        collection do
          get :remove_item
          patch :update_item
        end
      end

      resource :account
      resources :categories, only: [:show, :index]
      resources :product_stocks, only: [:index, :show, :update]
      resources :product_images, except: [:new, :edit]
      resources :featured_products, only: [:index]
      resources :wishlist_items
      resource :register
      resources :banner_items, only: [:index]
      resource :profile, only: [:show, :update]

      post :login, to: 'sessions#create'
      delete :logout, to: 'sessions#destroy'
    end
  end

  # Keep this at the bottom of routes
  comfy_route :cms, path: "/"
end
