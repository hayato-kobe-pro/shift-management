Rails.application.routes.draw do
  resources :relations
  resources :rooms
  resources :profiles #scaffoldでつくるとこうなる。この記述をすることでユーザー管理機能にアクセスすることができるようになります。
  devise_for :users
  root 'comments#index' 
  get 'comments/index' 
end