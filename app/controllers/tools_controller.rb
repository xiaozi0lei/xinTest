require 'mysql2'
require 'logger'

class ToolsController < ApplicationController
  def index
    if params[:commit] == "Search"

    # initial logger
    logger = Logger.new(STDOUT)
    
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
# 记得缩进
    else
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

