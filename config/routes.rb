Rails.application.routes.draw do
  resources :messages
  resources :user_chats
  resources :chats
  devise_for :users
  resources :projects
  root to: "chats#index"

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
