Rails.application.routes.draw do
 
  root to: "users#home"

  devise_for :users 

  resources :messages
  resources :user_chats
  resources :chats
  resources :projects
 
  get "/chat/:project_id/:chat_id"  => "chats#index"
  get "/all_users" => "users#all_users", as: :all_users
  get "/members" => "users#members", as: :members
  get "/home"  => "users#home", as: :home
  get ":user" => "users#profile", as: :profile
 
  
end
