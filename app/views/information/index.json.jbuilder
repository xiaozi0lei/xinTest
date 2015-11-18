json.array!(@information) do |information|
  json.extract! information, :id, :title, :description
  json.url information_url(information, format: :json)
end
