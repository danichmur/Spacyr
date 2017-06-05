json.extract! event, :name, :latitude, :longitude, :description, :kind, :image_url
json.url event_url(event, format: :json)
