require 'httparty'

假如(/^请求一个(.*)$/) do |url|
  @response = HTTParty.get(url)
  response = HTTParty.get(url, :default_timeout(5))
  puts response.body, response.code, response.message, response.headers.inspect
end

那么 /^返回数据应该包含:$/ do |string|
  expect(@response).to include(string)
end
