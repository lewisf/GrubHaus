GrubHaus::Application.routes.draw do

  devise_for :users

  namespace :api do
    resources :users, :only => [:show]

    get 'recipes/search' => 'recipes#search'
    get 'recipes/unpublished' => 'recipes#unpublished'
    get 'recipes/published' => 'recipes#published'
    get 'recipes/favorites' => 'recipes#favorites'
    post 'recipes/publish/:id' => 'recipes#publish'
    post 'recipes/favorite/:id' => 'recipes#favorite'
    post 'recipes/unfavorite/:id' => 'recipes#unfavorite'
    resources :recipes, :except => [:edit, :new] do
    end

    resources :comments, :except => [:edit, :new]
  end

  root :to => "home#index"
  match '*path' => 'home#index'
  
end
