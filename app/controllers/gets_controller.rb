class GetsController < ApplicationController
# 在执行方法之前先
# 1. 查找到对应的get数据
  before_action :set_get, only: [:show, :edit, :update, :destroy]
# 2. 设置好cucumber自动化测试文件的路径
  before_action :set_featureFile, only: [:create, :edit, :update, :destroy]

  # GET /gets
  # GET /gets.json
# 对应于前台的"get用例列表"
  def index
    if params[:project].nil?
      @gets = Get.all
    else
      case params[:project].to_i
        when 1 then
          @gets = Get.where(project: "1")
        when 2 then
          @gets = Get.where(project: "2")
        when 3 then 
          @gets = Get.where(project: "3")
        when 4 then
          @gets = Get.where(project: "4")
        when 5 then
          @gets = Get.where(project: "5")
        when 6 then
          @gets = Get.where(project: "6")
        when 7 then 
          @gets = Get.where(project: "7")
        when 8 then
          @gets = Get.where(project: "8")
      else
        raise "invalid project"
      end
    end
  end

  # GET /gets/1
  # GET /gets/1.json
  def show
  end

  # GET /gets/new
# 对应于前台的"新建Get用例"，创建用例页面，输入参数页面
  def new
    @get = Get.new
  end

  # GET /gets/1/edit
  def edit
  end

  # POST /gets
  # POST /gets.json
# 点击"新建Get用例页面"的创建按钮，后台执行的操作，保存测试用例，同时创建cucumber自动化测试用例
  def create
# 获取页面填写的get参数
    @get = Get.new(get_params)

# 在前台的view视图中直接调用iframe访问对应url
# 绝对 URL - 指向其他站点（比如 src="www.example.com/index.html"）
# 相对 URL - 指向站点内的文件（比如 src="index.html"）
# 判断commit参数是否为getData_ajax
    if params[:commit] == "getData_ajax" || params[:commit] == "获取数据"
      @get_url = @get[:url]

      @get_url = "http://#{@get[:url]}" unless @get[:url].include? "http"

      respond_to do |format|
# ajax异步调用
          format.js {}
      end
    else
# 如果commit不带参数，则转到创建成功页面或提示失败
      respond_to do |format|
        if @get.save
# 保存成功后，先创建cucumber测试用例
          Features.get_create(@featureFile, @get)
# 转到创建成功页面
          format.html { redirect_to @get, notice: 'Get was successfully created.' }
          format.json { render :show, status: :created, location: @get }
        else
# 创建失败，提示错误信息，重新渲染新建页面，保留输入信息
          format.html { render :new }
          format.json { render json: @get.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /gets/1
  # PATCH/PUT /gets/1.json
# 对应于编辑界面
  def update
    if params[:commit] == "getData_ajax" || params[:commit] == "获取数据"

      @get_url = params[:get][:url]
      @get_url = "http://#{params[:get][:url]}" unless params[:get][:url].include? "http"

      respond_to do |format|
# ajax异步调用
          format.js {}
      end
    else
      respond_to do |format|
# 如果用例更新成功后，先删除cucumber旧的测试用例，再添加更新后的测试用例到cucumber文件中
        if @get.update(get_params)
# 删除老的cucumber测试用例
          Features.destroy(@featureFile, @get)
# 添加新的cucumber测试用例
          Features.get_create(@featureFile, @get)
# 提示更新成功
          format.js {}
          format.html { redirect_to @get, notice: 'Get was successfully updated.' }
          format.json { render :show, status: :ok, location: @get }
        else
# 更新失败，提示失败原因
          format.js {}
          format.html { render :edit }
          format.json { render json: @get.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /gets/1
  # DELETE /gets/1.json
# 对应于用例删除按钮，删除用例
  def destroy
    @get.destroy
# 如果删除成功，则删除对应的cucumber测试用例
    Features.destroy(@featureFile, @get)
# 提示删除成功
    respond_to do |format|
      format.html { redirect_to gets_url, notice: 'Get was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
# 查找要操作的get对象
    def set_get
      @get = Get.find(params[:id])
    end

# 设置要编辑的cucumber feature文件
    def set_featureFile
      @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "get", "get_json.feature")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
# 限制参数，只允许需要的参数操作，保证安全
    def get_params
      params.require(:get).permit(:title, :url, :result, :project)
    end
end
