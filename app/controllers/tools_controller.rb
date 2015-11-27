require 'mysql2'
require 'logger'
class ToolsController < ApplicationController
  def index
    # initial logger
    logger = Logger.new(STDOUT)
    @commit = params[:commit]
    case params[:commit]
      when "Search cid_appid" then
        search_cid_appid
      when "Search name_id" then
        search_name_id
      else
    end
  end

  def search_cid_appid
    # assign the value of front end to variables
    front_name = params[:name]
    front_appId = params[:appId]
    front_cId = params[:cId]
    # handle the empty value for the variables
    front_name = nil if front_name.empty?
    front_appId = nil if front_appId.empty?
    front_cId = nil if front_cId.empty?

    # if name or appId have values
    if !front_name.nil? or !front_appId.nil?
      client = Mysql2::Client.new(:host => '10.10.1.115', :username => 'pubDbReader', :password => 'mGame2ReadOnly', :database => 'gamedev', :port => 5051)
    # find the back_appId and back_cId by name
      if !front_name.nil?
        results = client.query("select app_id, id from pt_game_basic_info where name = '#{front_name}'")
        if results.first.nil?
          colorRed
          logger.error "游戏名字不存在或者输入错误"
          colorNormal
        else
          colorYellow
          back_appId = results.first["app_id"]
          @front_appId = back_appId
          logger.info "table pt_game_basic_info => app_id = #{back_appId}"
          back_name = front_name
          @front_name = back_name
          logger.info "table pt_game_basic_info => name = #{back_name}"
    # game_id for pt_game_apk_package_info table search
          game_id = results.first["id"]
          logger.info "table pt_game_basic_info => id = #{game_id}"
          colorNormal
        end
      else
        results = client.query("select name,id from pt_game_basic_info where app_id = #{front_appId}")
        if results.first.nil?
          colorRed
          logger.error "appId不存在或者输入错误"
          colorNormal
        else
          colorYellow
          back_name = results.first["name"]
          @front_name = back_name
          logger.info "table pt_game_basic_info => name = #{back_name}"
          back_appId = front_appId
          @front_appId = back_appId
          logger.info "table pt_game_basic_info => app_id = #{back_appId}"
    # game_id for pt_game_apk_package_info table search
          game_id = results.first["id"]
          logger.info "table pt_game_basic_info => id = #{game_id}"
          colorNormal
        end
      end
    # search the package name by game id
      results = client.query("select package_name from pt_game_apk_package_info where game_id = #{game_id}")

      if results.first.nil?
        colorRed
        logger.error "package_name不存在"
        colorNormal
      else
        package_name = results.first["package_name"]
      end
    # close the mysql connection
      client.close

    # connect the MCP database
      client2 = Mysql2::Client.new(:host => '10.10.1.115', :username => 'pubDbReader', :password => 'mGame2ReadOnly', :database => 'MCP', :port => 5051)
      results = client2.query("select cid from bmh_info where packagename = '#{package_name}'")

      if results.first.nil?
        colorRed
        logger.error "cid不存在"
        colorNormal
      else
        back_cId = results.first["cid"]
        colorYellow
        logger.info "table bmh_info => cid = #{back_cId}"
        @front_cId = back_cId
        colorNormal
      end
    # close the mysql connection
      client2.close
    # if cid has value
    elsif !front_cId.nil?
    # connect the MCP database
      client_cid = Mysql2::Client.new(:host => '10.10.1.115', :username => 'pubDbReader', :password => 'mGame2ReadOnly', :database => 'MCP', :port => 5051)
      results = client_cid.query("select packagename from bmh_info where cid = '#{front_cId}'")

      if results.first.nil?
        colorRed
        logger.error "table bmh_info => packagename不存在"
        colorNormal
      else
        packagename = results.first["packagename"]
        colorYellow
        logger.info "table bmh_info => packagename = #{packagename}"
        colorNormal
      end
    # close the mysql connection
      client_cid.close

      client_cid2 = Mysql2::Client.new(:host => '10.10.1.115', :username => 'pubDbReader', :password => 'mGame2ReadOnly', :database => 'gamedev', :port => 5051)
    # search the package name by game id
      results = client_cid2.query("select game_id from pt_game_apk_package_info where package_name = '#{packagename}'")

      if results.first.nil?
        colorRed
        logger.error "table pt_game_apk_package_info => game_id不存在"
        colorNormal
      else
        game_id = results.first["game_id"]
      end

      results = client_cid2.query("select app_id, name from pt_game_basic_info where id = #{game_id}")
      if results.first.nil?
        colorRed
        logger.error "table pt_game_basic_info => Id不存在"
        colorNormal
      else
        colorYellow
        back_appId = results.first["app_id"]
        @front_appId = back_appId
        logger.info "table pt_game_basic_info => app_id = #{back_appId}"
        back_name = results.first["name"]
        @front_name = back_name
        logger.info "table pt_game_basic_info => name = #{back_name}"
        back_cId = front_cId
        @front_cId = back_cId
        logger.info "table bmh_info => cid = #{back_cId}"
        colorNormal
      end
    # close the mysql connection
      client_cid2.close
    else
    # no input value
      colorYellow
      logger.info "请提供name，cId，或者appId"
      colorNormal
    end
    respond_to do |format|
      format.js {}
    end
  end

  def search_name_id
    user_name = params[:user_name]
    baidu_name = params[:baidu_name]
    user_name = nil if user_name.empty?
    baidu_name = nil if baidu_name.empty?
    if !user_name.nil? or !baidu_name.nil?
      client = Mysql2::Client.new(:host => '10.10.0.207', :username => 'reader', :password => 'duoku2012', :database => 'mcp_user', :port => 3307)
      if !user_name.nil?
        result = client.query("select User_Id,User_ThirdId from mcp_user_info where User_Name = '#{user_name}' limit 1")
        if !result.first.nil?
          @user_id = result.first["User_Id"]
          @baidu_id = result.first["User_ThirdId"]
          colorYellow
          logger.info "username_id => user_id = #{@user_id}"
          logger.info "username_id => baidu_id = #{@baidu_id}"
          colorNormal
        else
          colorRed
          logger.error "table name_info => user_name:#{user_name}对应id不存在"
          colorNormal
        end
      end

      if !baidu_name.nil?
        baidu_result = client.query("select user_id,third_id from mcp_user_bd_eb where third_name = '#{baidu_name}' limit 1")
        if !baidu_result.first.nil?
          @user_id = baidu_result.first["user_id"]
          @baidu_id = baidu_result.first["third_id"]
          colorYellow
          logger.info "baiduname_id => user_id = #{@user_id}"
          logger.info "baiduname_id => baidu_id = #{@baidu_id}"
          colorNormal
        else
          colorRed
          logger.error "table name_info => baidu_name:#{baidu_name}对应id不存在"
          colorNormal
        end
      end
      client.close
    else
      # no input value
      colorYellow
      logger.info "请提供username或者baiduname"
      colorNormal
    end
    if !user_name.nil? and !baidu_name.nil?
      @warn = "同时输入用户名和百度用户名，按百度用户名查询"
      colorYellow
      logger.info "同时输入username和baiduname"
      colorNormal
    end
    respond_to do |format|
      format.js {}
    end
  end

  # redefine the logger methods
  # TODO
  # define the color method for the log output
  def colorNormal
    puts "\033[0m"
  end

  def colorRed
    puts "\033[31m"
  end

  def colorYellow
    puts "\033[33m"
  end
end

