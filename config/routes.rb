Rails.application.routes.draw do
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
 }
  namespace :admin do
    root to: "homes#top"
    get 'posts/index'
    get 'users/index'
  end
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }
  namespace :public do
    root to: "homes#top"
    get 'homes/about'
    resources :users, only: [:index,:show,:edit]
    resources :posts, only: [:index,:show,:edit]
  end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
