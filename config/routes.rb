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
   devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  namespace :public do
    root to: "homes#top"
    get 'homes/about'
    get "search" => "searches#search"
    resources :users, only: [:index,:show,:edit,:update,] do

      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'

      resources :chats, only: [:show, :create]

      member do
        get :favorites
      end

    end

    resources :posts, only: [:index,:show,:edit,:create,:destroy,:update] do
      resource :favorites, only: [:create,:destroy]
      resources :comments, only: [:create,:destroy]
    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
