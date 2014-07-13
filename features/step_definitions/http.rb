require 'pry'

假如(/^请求一个(.*)$/) do |url|
  @response = MyHttp.get(url)
end

那么 /^返回数据应该包含:$/ do |expected_table|
#  expected_table.diff!(@response)
  expected_table.raw.each do |row|
    expect(@response.body).to include(row[0])
  end
#  expect(@response).to include(expected_table.each)
end
