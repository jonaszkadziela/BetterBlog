class PostsController < ApplicationController
  before_action :set_post, only: %i(show edit update destroy)
  before_action :authenticate_user!, except: %i(index show)

  def index
    @posts = Post.page(params[:page]).order("created_at DESC")
  end

  def show
    @comments = @post.comments
    @new_comment = @post.comments.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: "Post created successfully!"
    else
      render :new
    end
  end

  def edit
    redirect_to root_path, alert: "You can only edit your own posts!" if @post.user != current_user
  end

  def update
    return redirect_to root_path, alert: "You can only edit your own posts!" if @post.user != current_user
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    return redirect_to root_path, alert: "You can only delete your own posts!" if @post.user != current_user
    if @post.destroy
      redirect_to posts_path, notice: "Post deleted successfully!"
    else
      redirect_to @post, alert: "Could not delete the post!"
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def resource_not_found
    redirect_to root_path, alert: "The post you are looking for could not be found."
  end
end
