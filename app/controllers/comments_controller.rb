class CommentsController < ApplicationController
  before_action :set_post, only: %i(create edit update destroy)
  before_action :set_comment, except: [:create]
  before_action :authenticate_user!, except: [:create]

  def create
    if user_signed_in?
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
      respond_to do |format|
        if @comment.save
          format.html { redirect_to post_path(@post), notice: "Comment created successfully!" }
          format.js { @new_comment = @post.comments.new }
        else
          @new_comment = @comment
          format.html { render "posts/show" }
          format.js { render "failed_save" }
        end
      end
    else
      redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing."
    end
  end

  def edit
    redirect_to post_path(@comment.post), alert: "You can only edit your own comments!" if @comment.user != current_user
  end

  def update
    if @comment.user != current_user
      return redirect_to post_path(@comment.post), alert: "You can only edit your own comments!"
    end
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: "Comment updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    if @comment.user != current_user
      return redirect_to post_path(@comment.post), alert: "You can only delete your own comments!"
    end
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to post_path(@comment.post), notice: "Comment deleted successfully!" }
        format.js
      else
        format.html { redirect_to @comment, alert: "Could not delete the comment!" }
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
