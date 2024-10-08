# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  authenticate :user, ->(user) { user.admin? } do
    mount RailsAdmin::Engine, at: 'admin', as: 'rails_admin'
  end


  resources :messages, only: [:create, :update]
  resources :user_chats, only: [:create, :update, :destroy]
  resources :projects, only: [:create, :update] do
    resources :chats,  except: [:show, :new, :edit] do
      member do
        get :messages
      end
    end
  end

  post 'projects/:project_id/chats/create_private_chat/:user_id', to: 'chats#create_private_chat',
                                                                  as: :create_private_chat
  get '/chat/:project_id/:chat_id' => 'chats#index'
  get '/home' => 'users#home', as: :home
  get '/all_users' => 'users#all_users', as: :all_users
  get ':user' => 'users#profile', as: :profile
end
