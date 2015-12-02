require 'pry'
class PostsController < ApplicationController
# 在执行方法之前先
# 1. 查找到对应的get数据
  before_action :set_post, only: [:show, :edit, :update, :destroy]
# 2. 设置好cucumber自动化测试文件的路径
  before_action :set_featureFile, only: [:create, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
# 对应于前台的"post用例列表"
  def index
    if params[:project].nil?
      @posts = Post.all
      @posts = Post.paginate :page => params[:page],
                           :per_page => 10
    else
      @posts = Post.where(project: "#{params[:project].to_i}").order("title").paginate :page => params[:page],
                                                                                       :per_page => 10
#      case params[:project].to_i
#        when 1 then
#          @posts = Post.where(project: "1")
#        when 2 then
#          @posts = Post.where(project: "2")
#        when 3 then
#          @posts = Post.where(project: "3")
#        when 4 then
#          @posts = Post.where(project: "4")
#        when 5 then
#          @posts = Post.where(project: "5")
#        when 6 then
#          @posts = Post.where(project: "6")
#        when 7 then
#          @posts = Post.where(project: "7")
#        when 8 then
#          @posts = Post.where(project: "8")
#        when 9 then
#          @posts = Post.where(project: "9")
#      else
#        raise "invalid project"
#      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/test
# 对应于前台的"Post测试"，执行接口测试
  def test
    @post = Post.new
  end

  # GET /posts/new
# 对应于前台的"新建Post用例"，创建用例页面，输入参数页面
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
# 点击"新建Post用例页面"的创建按钮，后台执行的操作，保存测试用例，同时创建cucumber自动化测试用例
  def create
    data = @post[:data]
    url = @post[:url]
    case @post[:project].to_i
      when 1, 2, 3, 4 then
        key = ENV['KEY1']
      when 5, 6, 9  then
        key = ENV['KEY2']
      when 8 then
        key = ENV['KEY3']
      else
        key = 'none'
#raise "invalid key"
    end
# 对post data数据加密后发送给后台server，获取后台server的返回结果，返回给前台展示
# 判断commit参数是否为getData_ajax，利用ajax技术局部更新
    if params[:commit] == "Get Data" || params[:commit] == "获取数据"
# require 加密类
      require 'AES'
      # 此处实现AES/ECB/pkcs5padding加密，Base64编码
      # 利用httparty的post类方法发送加密的data到server
      # 此处的self.class.get调用的是include HTTParty类中的方法post
      if key == "none"
        @preview = AES.get_json_by_post_without_encode(url, data)
      else
        # preview_result只是临时变量，存储测试返回的数据，不入库
        @preview = AES.get_json_by_post(url, key, data)
      end
      begin
        array = @post[:result].gsub(' ','').chomp.split("\r\n")
        @wrongmsg = ""
        i = 0
        for i in 0..array.length-1
          allin = true
          @preview_results = @preview.force_encoding("UTF-8").include?"#{array[i]}"
          unless @preview_results then
            allin = false
            @wrongmsg = "#{array[i]} 在返回结果中未匹配到"
            break
          else
            i += 1
          end
        end
        if allin then
          @wrongmsg = "对比成功"
        end
        @preview_result = @preview
      rescue Exception => e
        @error = "Error: #{e}"
      end
      respond_to do |format|
        format.js {}
      end
    else
# 正常commit，保存输入参数到数据库
      respond_to do |format|
        if @post.save
# 保存成功后，先创建cucumber测试用例
          Features.post_create(@featureFile, @post)
# 转到创建成功页面
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
          format.js { render :layout => false }
        else
# 创建失败，提示错误信息，重新渲染新建页面，保留输入信息
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
          format.js { render :layout => false, :status => 406 }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
# 对应于编辑界面
  def update
    if params[:commit] == "Get Data" || params[:commit] == "获取数据"
      @post = Post.new(post_params)
    end
    data = @post[:data]
    url = @post[:url]
    case @post[:project].to_i
      when 1, 2, 3, 4 then
        key = ENV['KEY1']
      when 5, 6, 9  then
        key = ENV['KEY2']
      when 8 then
        key = ENV['KEY3']
      else
        key = 'none'
#raise "invalid key"
    end
# 对post data数据加密后发送给后台server，获取后台server的返回结果，返回给前台展示
# 判断commit参数是否为getData_ajax，利用ajax技术局部更新
    if params[:commit] == "Get Data" || params[:commit] == "获取数据"
# require 加密类
      require 'AES'
      # 此处实现AES/ECB/pkcs5padding加密，Base64编码
      # 利用httparty的post类方法发送加密的data到server
      # 此处的self.class.get调用的是include HTTParty类中的方法post
      if key == "none"
        @preview = AES.get_json_by_post_without_encode(url, data)
      else
        # preview_result只是临时变量，存储测试返回的数据，不入库
        @preview = AES.get_json_by_post(url, key, data)
      end
      begin
        array = @post[:result].gsub(' ','').chomp.split("\r\n")
        @wrongmsg = ""
        i = 0
        for i in 0..array.length-1
          allin = true
          @preview_results = @preview.force_encoding("UTF-8").include?"#{array[i]}"
          unless @preview_results then
            allin = false
            @wrongmsg = "#{array[i]} 在返回结果中未匹配到"
            break
          else
            i += 1
          end
        end
        if allin then
          @wrongmsg = "对比成功"
        end
        @preview_result = @preview
      rescue Exception => e
        @error = "Error: #{e}"
      end

#@post[:result] = JSON.pretty_generate(JSON.parse(result.force_encoding("UTF-8")))
      respond_to do |format|
        format.js {}
      end
    else
      respond_to do |format|
# 如  果用例更新成功后，先删除cucumber旧的测试用例，再添加更新后的测试用例到cucumber文件中
        if @post.update(post_params)
# 删  除老的cucumber测试用例
          Features.destroy(@featureFile, @post)
# 添  加新的cucumber测试用例
          Features.post_create(@featureFile, @post)
# 提  示更新成功
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
          format.js { render :layout => false }
        else
# 更  新失败，提示失败原因
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
          format.js { render :layout => false, :status => 406 }
        end
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
# 对应于用例删除按钮，删除用例
  def destroy
    @post.destroy
# 如果删除成功，则删除对应的cucumber测试用
    Features.destroy(@featureFile, @post)
# 提示删除成功
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
# 查找要操作的post对象
    def set_post
      @post = Post.find(params[:id])
    end

# 设置要编辑的cucumber feature文件
    def set_featureFile
      if @post.nil?
# 获取页面填写的post参数
        @post = Post.new(post_params)
      end
      case @post[:project].to_i
        when 1 then
          @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "standalone.feature")
        when 2 then
          @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "online.feature")
        when 3 then
          @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "18183.feature")
        when 4 then
          @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "compete.feature")
        when 5 then
          @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "ios.feature")
        when 6 then
          @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "mobileassistant.feature")
        when 7 then
          @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "onesdk.feature")
        when 8 then
          @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "CRM.feature")
        when 9 then
          @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "baidu_game.feature")
        else
          raise "invalid project"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
# 限制参数，只允许需要的参数操作，保证安全
    def post_params
      params_tmp = params.require(:post).permit(:title, :url, :parameter, :data, :result)
      params_tmp[:project] = params[:project]
      params_tmp
    end
end
