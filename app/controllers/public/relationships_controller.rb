class Public::RelationshipsController < ApplicationController

  # フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  #フォロー一覧画面
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  #フォロワー一覧画面
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
