Rails.application.routes.draw do
  get 'followings/create', to: 'followings#create', as: 'add_follow'
    get 'followings/destroy'
  devise_for :users, :controllers => {registrations: 'registrations'}
  
  resources :users, only: %i[show]
  resources :tweets
  root "tweets#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
