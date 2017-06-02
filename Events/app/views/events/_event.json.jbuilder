json.extract! event, :id, :name, :latitude, :longitude, :description, :kind, :image_url, :created_at, :updated_at
json.url event_url(event, format: :json)
