Rails.application.routes.draw do

  devise_for :users
  #アプリを起動した瞬間にtopアクションを実行
  root to: 'homes#top'
  get 'home/about', to: "homes#about"
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  #create：書籍の投稿処理、update：更新処理、destroy：削除処理

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
