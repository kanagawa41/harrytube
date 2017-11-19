class PostsController < ApplicationController
  layout "blog_home1"

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    origin_person? @post.user.id

    @comments, @is_favorite, @favorite_size = PostsService.show  @post
  end

  # GET /posts/new
  def new
    return unless signed_in?

    @post = Post.new(user_id: current_user.id)
  end

  # GET /posts/1/edit
  def edit
    return unless origin_signed_in? @post.user.id
  end

  # POST /posts
  # POST /posts.json
  def create
    return unless signed_in?

    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '投稿を作成しました。' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    origin_signed_in?(@post.user.id)

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '投稿に成功しました。' }
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
    origin_signed_in?(@post.user.id)

    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '投稿を削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :description, :youtube_video_id, :tags)
    end
end
