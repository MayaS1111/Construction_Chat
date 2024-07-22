Rails.application.routes.draw do
  devise_for :users
  resources :projects
  root chats#index

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
