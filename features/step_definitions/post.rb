假如(/^运行的用例的标题为"(.*?)"$/) do |title|
  logger = Logger.new(STDOUT)
  logger.info("\n")
  logger.info("="*30)
  logger.info("当前运行的用例为：#{title}")
  logger.info("="*30)
end

假如 /^发送一个(.*)项目(.*)参数(.*)数据的post方法的请求到服务器端口$/ do |project, parameter, data|
  if ENV['SERVER_ADDRESS']
    url = ENV['SERVER_ADDRESS']
  else
    raise "请设置服务器地址！"
  end

  url = url + "/" + parameter unless parameter.nil?

  case project.to_i
    when 1, 2, 3, 4  then
      key = ENV['KEY1']
    when 5, 6, 9 then
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
    #expect(@response.to_json).to have_content(row[0])
    expect(JSON.pretty_generate(JSON.parse(@response.force_encoding("UTF-8")))).to have_content(row[0])
  end
end
