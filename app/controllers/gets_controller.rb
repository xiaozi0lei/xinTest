class GetsController < ApplicationController
  before_action :set_get, only: [:show, :edit, :update, :destroy]
  before_action :set_featureFile, only: [:create, :edit, :update, :destroy]

include HTTParty
default_timeout 3
  # GET /gets
  # GET /gets.json
  def index
    @gets = Get.all
    
  end

  # GET /gets/1
  # GET /gets/1.json
  def show
  end

  # GET /gets/new
  def new
    @get = Get.new
  end

  # GET /gets/1/edit
  def edit
  end

  # POST /gets
  # POST /gets.json
  def create
    @get = Get.new(get_params)

    if params[:commit] == "test"
      #@get[:result] = self.class.get(@get[:url])
      respond_to do |format|
          format.js {}
      end
    else
      respond_to do |format|
        if @get.save
          Features.get_create(@featureFile, @get)
          format.html { redirect_to @get, notice: 'Get was successfully created.' }
          format.json { render :show, status: :created, location: @get }
        else
          format.html { render :new }
          format.json { render json: @get.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /gets/1
  # PATCH/PUT /gets/1.json
  def update
    respond_to do |format|
      if @get.update(get_params)
        Features.get_destroy(@featureFile, @get)
        Features.get_create(@featureFile, @get)
        format.html { redirect_to @get, notice: 'Get was successfully updated.' }
        format.json { render :show, status: :ok, location: @get }
      else
        format.html { render :edit }
        format.json { render json: @get.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gets/1
  # DELETE /gets/1.json
  def destroy
    @get.destroy
    Features.get_destroy(@featureFile, @get)
    respond_to do |format|
      format.html { redirect_to gets_url, notice: 'Get was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_get
      @get = Get.find(params[:id])
    end

    def set_featureFile
      @featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "get", "get_json.feature")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def get_params
      params.require(:get).permit(:title, :url, :result)
    end
end
