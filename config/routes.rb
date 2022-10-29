Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top#index"
  get "about" => "top#about" , as: "about"

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
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]

  resources :entries
end
