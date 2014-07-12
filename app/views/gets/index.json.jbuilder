json.array!(@gets) do |get|
  json.extract! get, :id, :url, :result
  json.url get_url(get, format: :json)
end
