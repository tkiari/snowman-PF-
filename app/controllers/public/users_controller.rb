class Public::UsersController < ApplicationController

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @post = Post.new
  end

  def show
    @finduser = User.find(params[:id])
    @posts = @finduser.posts
    @user = User.find(current_user.id)
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to public_user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to public_user_path(@user)
    else
    render :edit
    end
  end

 #いいね一覧は自分以外のuserは入れないようにする
  def favorites
    @user = User.find(params[:id])
    if @user == current_user
      favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
      @favorite_posts = Post.find(favorites)
      render :favorites
    else
      redirect_to public_user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
end
