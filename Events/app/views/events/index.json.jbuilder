json.events @events do |event|
  json.id event.id
  json.name event.name
  json.latitude event.latitude
  json.longitude event.longitude
  json.description event.description
  json.kind event.kind
end