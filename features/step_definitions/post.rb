假如 /^请求一个post方法的来自(.*)项目带有(.*)数据的(.*)$/ do |project, data, url|
  case project.to_i
    when 1, 2, 3, 4  then
      key = ENV['KEY1']
    when 5, 6  then
      key = ENV['KEY2']
    when 8 then
      key = ENV['KEY3']
    else
      raise "invalid key"
  end
  @response = AES.get_json_by_post(url, key, data)
end

那么 /^返回的post数据应该包含:$/ do |expected_table|
  expected_table.raw.each do |row|
    expect(@response).to have_content(row[0])
  end
end
