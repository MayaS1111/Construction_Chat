Rails.application.routes.draw do
 
  root to: "users#home"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # authenticate :user, ->(user) { user.admin? } do
  #   mount RailsAdmin::Engine, at: "admin", as: "rails_admin"
  # end
   
  resources :messages
  resources :user_chats
  resources :projects do
    resources :chats
  end
 
  # /projects/:project_id/chats, to: "chats#index"
  get "/chat/:project_id/:chat_id"  => "chats#index"

  get "/all_users" => "users#all_users", as: :all_users
  get "/members" => "users#members", as: :members
  get "/home"  => "users#home", as: :home
  get ":user" => "users#profile", as: :profile
 
  
end
