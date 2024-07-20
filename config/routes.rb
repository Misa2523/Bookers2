Rails.application.routes.draw do
  #アプリを起動した瞬間にtopアクションを実行
  root to: 'homes#top'
  get 'home/about', to: "homes#about"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
