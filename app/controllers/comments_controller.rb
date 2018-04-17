class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, except: [:create]
  before_action :authenticate_user!

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      @new_comment = @post.comments.new
      redirect_to post_path(@post), notice: "Comment created successfully!"
    else
      @new_comment = @comment
      render 'posts/show'
    end
  end

  def edit
    if @comment.user != current_user
      redirect_to root_path, alert: "You can only edit your own comments!"
    end
  end

  def update
    if @comment.user != current_user
      redirect_to root_path, alert: "You can only edit your own comments!"
    else
      if @comment.update(comment_params)
        redirect_to post_path(@comment.post), notice: "Comment updated successfully!"
      else
        render :edit
      end
    end
  end

  def destroy
    if @comment.user != current_user
      redirect_to root_path, alert: "You can only delete your own comments!"
    else
      if @comment.destroy
        redirect_to post_path(@comment.post), notice: "Comment deleted successfully!"
      else
        redirect_to @comment, alert: "Could not delete the comment!"
      end
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def resource_not_found
    redirect_to root_path, alert: "The comment you are looking for could not be found."
  end
end
