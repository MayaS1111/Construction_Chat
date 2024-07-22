json.extract! project, :id, :owner_id, :name, :description, :location, :member_count, :prioject_type, :created_at, :updated_at
json.url project_url(project, format: :json)
