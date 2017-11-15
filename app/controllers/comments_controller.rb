class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    return unless origin_signed_in?(@post.user.user_info.id)
  end

  # POST /comments
  # POST /comments.json
  # FIXME: AJAXのみ対応にする。
  # def create
  #   @comment = Comment.new(comment_params)

  #   @comment.user_id = current_user.id

  #   respond_to do |format|
  #     if @comment.save
  #       format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
  #       format.json { render :show, status: :created, location: @comment }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # POST /comments
  # POST /comments.json
  def create
$logger.info "whatwhat"
    # FIXME: 判定が正しくされない
    # request_ajax?
$logger.info "whatwhat2"

    signed_in?

    @comment = Comment.new(comment_params)

    @comment.user_id = current_user.id

    if @comment.save
$logger.info "whatwhat3"
      render json: {"result" => "ok"}, status: 200
    else
$logger.info "whatwhat4"
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    request_ajax?

    origin_signed_in?(@post.user.user_info.id)

    respond_to do |format|
      if @comment.update(comment_params)
        format.json { render :show, status: :ok, location: @comment }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    request_ajax?

    @comment.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :comment)
    end
end
