假如(/^请求一个(.*)$/) do |url|
  @response = MyHttp.get(url)
#  response = HTTParty.get(url)
#  puts response.body, response.code, "gusun-->", response.message, response.headers.inspect
end

那么 /^返回数据应该包含:$/ do |string|
  expect(@response).to include(string)
end
