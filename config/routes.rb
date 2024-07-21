Rails.application.routes.draw do

  devise_for :users
  #アプリを起動した瞬間にtopアクションを実行
  root to: 'homes#top'
  get 'home/about', to: "homes#about"
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]

      # ↓消す？
  #get '/about', to: 'pages#about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
