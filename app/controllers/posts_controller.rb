class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :set_featureFile, only: [:create, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

		if params[:commit] == "test"
			require 'AES'
			#此处实现AES/ECB/pkcs5padding加密，Base64编码
			#利用httparty的post类方法发送加密的data到server
			# 此处的self.class.get调用的是include HTTParty类中的方法post
			@post[:result] = AES.get_json_by_post
			respond_to do |format|
			  format.js {}
			end
		else
    	respond_to do |format|
      	if @post.save
					Features.post_create(@featureFile, @post)
      	  format.html { redirect_to @post, notice: 'Post was successfully created.' }
      	  format.json { render :show, status: :created, location: @post }
      	else
      	  format.html { render :new }
      	  format.json { render json: @post.errors, status: :unprocessable_entity }
      	end
    	end
		end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
				Features.destroy(@featureFile, @post)
				Features.post_create(@featureFile, @post)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
		Features.destroy(@featureFile, @post)
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

		def set_featureFile
			@featureFile = File.join(File.dirname(__FILE__), "..", "..", "features", "post", "post_json.feature")
		end
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :project, :url, :data, :result)
    end
end
