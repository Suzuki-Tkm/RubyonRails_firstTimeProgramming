Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top#index"
  get "about" => "top#about" , as: "about"
  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"

  1.upto(18) do |n|
    get "lesson/step#{n}(/:name)" => "lesson#step#{n}"
  end
  get "lesson/step19(/:name)" => "lesson#step19"
  get "lesson/step20(/:price)" => "lesson#step20"
  get "lesson/add(/:n)(/:m)" => "lesson#add"
  get "lesson/error" => "lesson#error"
  get "lesson/db_practice" => "lesson#db_practice"

  resources :members do
    get "search" , on: :collection
    resources :entries, only: [:index]
    resources :duties, only: [:index]
  end

  resources :entries do
    patch "like", "unlike", on: :member
    get "voted", on: :collection
    get "voted" , on: :member
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]

  resources :entries
  resources :duties

  namespace :admin do
    root "top#index"
  end
end
