Rails.application.routes.draw do
  get 'books/index'
  get 'books/show'
  get 'books/edit'
  get 'books/update'
  #アプリを起動した瞬間にtopアクションを実行
  root to: 'homes#top'
  get '/about', to: 'pages#about'

      #↓消すかも？
  get 'home/about', to: "homes#about"

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
