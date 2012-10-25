GrubHaus::Application.routes.draw do

  devise_for :users

  namespace :api do
    resources :users
    resources :recipes
  end

  root :to => "home#index"
  
end
