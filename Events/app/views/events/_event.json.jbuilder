json.extract! event, :id, :name, :latitude, :longitude, :description, :kind, :created_at, :updated_at
json.url event_url(event, format: :json)
