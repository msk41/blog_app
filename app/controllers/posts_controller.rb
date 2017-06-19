class PostsController < ApplicationController

  def index
    @posts = Post.order("created_at DESC")
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

  private

    def post_params
      params.require(:post).permit(:image, :title, :text)
    end
end
