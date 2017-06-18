class CommentsController < ApplicationController

  def create
    @comment = Comment.create(text: comment_params[:text], name: comment_params[:name], post_id: comment_params[:post_id])
    redirect_to "posts/#{@comment.post_id}"
  end

  private

    def comment_params
      params.permit(:text, :name, :post_id)
    end
end
