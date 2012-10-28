GrubHaus::Application.routes.draw do

  devise_for :users

  namespace :api do
    resources :users, :only => [:show]
    resources :recipes, :except => [:edit, :new]
    resource :comments, :except => [:edit, :new]
  end

  root :to => "home#index"
  
end
