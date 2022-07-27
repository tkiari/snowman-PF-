class Public::RelationshipsController < ApplicationController

  # フォローするとき
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    #redirect_to request.referer

#タブ間での非同期通信（タブ切り替えの際に更新されるようにするため
    @my_user = User.find(current_user.id)
    #フォロー一覧
    @users1 = @my_user.followings
  end

  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
    #redirect_to request.referer

#タブ間での非同期通信（タブ切り替えの際に更新されるようにするため
    @my_user = User.find(current_user.id)
    #フォロー一覧
    @users1 = @my_user.followings
  end

end
