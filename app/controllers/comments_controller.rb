class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :edit, :update]
  before_action :set_comment, only: [:destroy]

  def create
    @comment = Comment.create(comment_params.merge(post: @post))
    if @comment.save
      flash[:success] = "Comment created successfully!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@comment.post.id)
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:name, :body)
  end
end
