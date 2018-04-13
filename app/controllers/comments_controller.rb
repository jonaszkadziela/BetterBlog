class CommentsController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_comment, only: [:destroy, :edit, :update]
  before_action :authenticate_user!, except: [:create]

  def create
    @comment = Comment.create(comment_params.merge(post: @post))
    if @comment.save
      redirect_to post_path(@post), notice: "Comment created successfully!"
    else
      render 'posts/show'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: "Comment updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      redirect_to post_path(@comment.post), notice: "Comment deleted successfully!"
    else
      redirect_to @comment, alert: "Could not delete the comment!"
    end
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
