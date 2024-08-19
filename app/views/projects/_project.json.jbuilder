# frozen_string_literal: true

json.extract! project, :id, :owner_id, :name, :description, :location, :member_count, :project_type, :created_at,
              :updated_at
json.url project_url(project, format: :json)
