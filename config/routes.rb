GrubHaus::Application.routes.draw do

  devise_for :users

  namespace :api do
    get 'user' => 'users#show'
    resources :users, :only => [:show, :update]

    get 'recipes/search' => 'recipes#search'
    get 'recipes/unpublished' => 'recipes#unpublished'
    get 'recipes/published/:id' => 'recipes#published'
    get 'recipes/published' => 'recipes#published'
    get 'recipes/favorites/:id' => 'recipes#favorites'
    get 'recipes/favorites' => 'recipes#favorites'
    post 'recipes/favorite/:id' => 'recipes#favorite'
    post 'recipes/unfavorite/:id' => 'recipes#unfavorite'
    post 'recipes/fork/:id' => 'recipes#fork'
    resources :recipes, :except => [:new] do
    end

    resources :comments, :except => [:edit, :new]
  end

  root :to => "home#index"
  match '*path' => 'home#index'
  
end
