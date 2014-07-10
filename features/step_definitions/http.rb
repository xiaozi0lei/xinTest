# language: zh-CN

require 'httparty'

假如(/^请求一个(.*)$/) do |url|
  @response = HTTParty.get(url)
end

那么 /^返回数据应该包含:$/ do |string|
  puts @response
  expect(@response.include(string))
end
