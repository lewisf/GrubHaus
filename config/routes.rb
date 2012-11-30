GrubHaus::Application.routes.draw do

  devise_for :users

  namespace :api do
    resources :users, :only => [:show]

    get 'recipes/search' => 'recipes#search'
    get 'recipes/unpublished' => 'recipes#unpublished'
    get 'recipes/published' => 'recipes#published'
    get 'recipes/favorites' => 'recipes#favorites'
    put 'recipes/publish/:id' => 'recipes#publish'
    put 'recipes/favorite/:id' => 'recipes#favorite'
    resources :recipes, :except => [:edit, :new] do
    end

    resources :comments, :except => [:edit, :new]
  end

  root :to => "home#index"
  match '*path' => 'home#index'
  
end
