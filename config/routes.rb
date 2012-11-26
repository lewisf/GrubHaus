GrubHaus::Application.routes.draw do

  devise_for :users

  namespace :api do
    resources :users, :only => [:show]
      get 'recipes/search' => 'recipes#search'
    resources :recipes, :except => [:edit, :new] do
    end
    resources :comments, :except => [:edit, :new]
  end

  root :to => "home#index"
  match '*path' => 'home#index'
  
end
