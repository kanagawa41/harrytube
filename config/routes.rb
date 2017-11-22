###
# Manage用のルーティング
###
Rails.application.routes.draw do

  root :to => 'harries#index'

  devise_for :users

  resources :user_pets

  resources :posts

  resources :user_infos, only: [:index, :show, :edit, :update], param: :hash_id do
    collection do
      get ':hash_id/user_pets', to: 'user_pets#user_index', as: 'user_pets'
      get ':hash_id/posts', to: 'posts#user_index', as: 'posts'
    end
  end

  resources :harries do
    collection do
      get 'index'
      get 'information'
      get 'feature'
      get 'ranking'
      get 'tag'
    end
  end

  resources :comments do
    collection do
      get 'index'
      post 'create'
    end
  end

  resources :favorites do
    collection do
      get 'index'
      post 'create'
      delete 'destroy'
    end
  end

  resources :samples do
    collection do
      get 'index'
      get 'services'
      get 'contact'
      get 'sidebar'
      get 'about'
      get 'blog_home_1'
      get 'blog_home_2'
      get 'blog_post'
      get 'faq'
      get 'full_width'
      get 'portfolio_1_col'
      get 'portfolio_2_col'
      get 'portfolio_3_col'
      get 'portfolio_4_col'
      get 'portfolio_item'
      get 'pricing'
    end
  end
end
