# frozen_string_literal: true

json.extract! user_chat, :id, :created_at, :updated_at
json.url user_chat_url(user_chat, format: :json)
