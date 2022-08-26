class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy show_qrcodes activation_reset ]
  before_action :require_same_user, only: %i[ show edit update destroy ]
  before_action :require_user, only: %i[ index ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @search = @post.items.ransack(params[:q])
    @search.sorts = "created_at DESC" if @search.sorts.empty?
    @items = @search.result.page(params[:page])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to current_user, notice: "新規イベントが作成されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      redirect_to current_user, notice: "イベントが更新されました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    redirect_to current_user, notice: "イベントが削除されました", status: :see_other
  end

  # QRコードを表示・印刷する
  def show_qrcodes
  end

  # 景品の取得状態をリセットする
  def activation_reset
    @post.items.each do |item|
      if item.item_got_user? && !item.lose?
        item.update_attribute(:item_got_user, nil)
      end
    end
    redirect_to @post, notice: "景品の取得状態がリセットされました"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title)
    end

    def require_same_user
      if current_user != @post.user
        flash[:alert] = "ご自身以外のアカウントの閲覧・編集はできません"
        redirect_to root_path
      end
    end

end
