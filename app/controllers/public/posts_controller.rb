class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = Post.new
    @posts = Post.all
    @user = User.find(current_user.id)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to public_post_path(@post.id)
    else
    @posts = Post.all
    @user = User.find(current_user.id)
    render :index
    end
  end

  def show
    @post1 = Post.new
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to request.referer
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to public_posts_path
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
    redirect_to public_post_path(@post.id)
    else
    render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title,:opinion,:post_image)
  end

end
