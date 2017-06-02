json.events @events do |event|
  json.name event.name
  json.latitude event.latitude
  json.longitude event.longitude
  json.description event.description
end