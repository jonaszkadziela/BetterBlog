class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    @comment = @post.comments.create(comment_params)
    if @comment.save
      flash[:success] = "Comment created successfully!"
    else
      flash[:error] = "Could not create the comment!"
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post.comments.find(params[:id]).destroy
    redirect_to post_path(@post)
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def comment_params
    params.require(:comment).permit(:name, :body)
  end
end
