class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :edit, :update, :destroy]

  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment created successfully!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
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
