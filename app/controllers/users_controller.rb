class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order('created_at DESC')
    @tweet = @user.tweets.build
  end

  def search
    @users = User.where('name LIKE ?', "%#{params[:q]}%")
  end
end
