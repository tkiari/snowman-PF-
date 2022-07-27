class Public::FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    @favorite = current_user.favorites.new(post_id: post.id)
    @favorite.save
    #redirect_to request.referer
    
    #タブ間での非同期通信（タブ切り替えの際に更新されるようにするため
    @my_user = User.find(current_user.id)
    #フォロー一覧
    @users1 = @my_user.followings
  end

  def destroy
    post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: post.id)
    @favorite.destroy
    #redirect_to request.referer
    
    #タブ間での非同期通信（タブ切り替えの際に更新されるようにするため
    @my_user = User.find(current_user.id)
    #フォロー一覧
    @users1 = @my_user.followings
  end

end
