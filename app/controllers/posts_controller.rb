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
    else
      case params[:project].to_i
      when 1 then
        @posts = Post.where(project: "1")
      when 2 then
        @posts = Post.where(project: "2")
      when 3 then 
        @posts = Post.where(project: "3")
      when 4 then
        @posts = Post.where(project: "4")
      when 5 then
        @posts = Post.where(project: "5")
      when 6 then
        @posts = Post.where(project: "6")
      when 7 then 
        @posts = Post.where(project: "7")
      when 8 then
        @posts = Post.where(project: "8")
      else
        raise "invalid project"
    end

    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
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
# 获取页面填写的post参数
    @post = Post.new(post_params)
    data = @post[:data]
    url = @post[:url]
    case @post[:project].to_i
      when 1, 2, 3, 4, 5 then
        key = ENV['KEY1']
      when 6, 7, 8 then
        key = ENV['KEY2']
      else
        raise "invalid key"
    end

# 对post data数据加密后发送给后台server，获取后台server的返回结果，返回给前台展示
# 判断commit参数是否为getData_ajax，利用ajax技术局部更新
    if params[:commit] == "获取数据" || params[:commit] == "Get Data"
# require 加密类
      require 'AES'
      # 此处实现AES/ECB/pkcs5padding加密，Base64编码
      # 利用httparty的post类方法发送加密的data到server
      # 此处的self.class.get调用的是include HTTParty类中的方法post
      @post[:result] = AES.get_json_by_post(url, key, data)
#@post[:result] = JSON.pretty_generate(JSON.parse(result.force_encoding("UTF-8")))
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
        else
# 创建失败，提示错误信息，重新渲染新建页面，保留输入信息
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
# 对应于编辑界面
  def update
    respond_to do |format|
# 如果用例更新成功后，先删除cucumber旧的测试用例，再添加更新后的测试用例到cucumber文件中
      if @post.update(post_params)
# 删除老的cucumber测试用例
        Features.destroy(@featureFile, @post)
# 添加新的cucumber测试用例
        Features.post_create(@featureFile, @post)
# 提示更新成功
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
# 更新失败，提示失败原因
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
# 对应于用例删除按钮，删除用例
  def destroy
    @post.destroy
# 如果删除成功，则删除对应的cucumber测试用例
    Features.destroy(@featureFile, @post)
# 提示删除成功
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
# 查找要操作的get对象
    def set_post
      @post = Post.find(params[:id])
    end

# 设置要编辑的cucumber feature文件
    def set_featureFile
      @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "post_json.feature")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
# 限制参数，只允许需要的参数操作，保证安全
    def post_params
      params_tmp = params.require(:post).permit(:title, :url, :data, :result)
      params_tmp[:project] = params[:project]
      params_tmp
    end
end
