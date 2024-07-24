Rails.application.routes.draw do
  root to: "chats#index"

  devise_for :users

  resources :messages
  resources :user_chats
  resources :chats
  resources :projects
 

  # get ":project_num" => "chats#show", as: :project
  # get ":project_num/:chat_num" => "chats#chat", as: :chat

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get "/your_first_screen" => "pages#first"
end
