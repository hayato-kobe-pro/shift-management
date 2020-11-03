Rails.application.routes.draw do
  resources :schedules
  resources :relations
  resources :rooms
  resources :profiles #scaffoldでつくるとこうなる。この記述をすることでユーザー管理機能にアクセスすることができるようになります。
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users
  root 'comments#index' 
  get 'comments/index' 
end

