class PostsController < ApplicationController
  before_action :admin_user, only: [:admin, :new, :create, :edit, :update, :destroy]
  before_action :make_archive

  def admin
    @posts = Post.order("created_at DESC").paginate(page: params[:page])
  end

  def index
    @posts = Post.order("created_at DESC").paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post created"
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post deleted"
    redirect_to root_url
  end

  def search
    # 検索フォームのキーワードをあいまい検索して、postsテーブルから20件の作品情報を取得する
    @posts = Post.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
  end

  # 年月のパラメータを受け取って、投稿を絞る
  def archives
    @yyyymm_now = params[:yyyymm]
    @posts = Post.where("strftime('%Y%m', posts.updated_at) = '"+ @yyyymm_now +"' ").order(:id).paginate(page: params[:page])
  end

  private

    def post_params
      params.require(:post).permit(:image, :title, :text)
    end

    # beforeアクション

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    # アーカイブを集計
    def make_archive
      @archives = Post.group("strftime('%Y%m', posts.updated_at)").order("strftime('%Y%m', posts.updated_at) desc").count
    end
end

