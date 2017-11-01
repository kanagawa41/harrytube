###
# Manage用のルーティング
###
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'diaries#test1'

  resources :diaries do
    collection do
      get 'test1'
      get 'test2'
    end
  end
end
