Rails.application.routes.draw do
 
  root to: "chats#index"

  devise_for :users 

  resources :messages
  resources :user_chats
  resources :chats
  resources :projects

  get "/chat/:project_id"  => "chats#index"
  get "/chat/:project_id/:chat_id"  => "chats#index"
  get ":user" => "users#profile", as: :profile
  get ":user/:project/:chat" => "chats#home", as: :home
 



  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get "/your_first_screen" => "pages#first"
end
