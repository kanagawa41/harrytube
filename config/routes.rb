###
# Manage用のルーティング
###
Rails.application.routes.draw do
  devise_for :users

  root :to => 'harries#index'

  resources :harries do
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
