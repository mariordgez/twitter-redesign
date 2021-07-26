class FollowingsController < ApplicationController
  def create
    @following =
      current_user.followings.build(
        user_id: current_user.id,
        following_id: params[:following_id],
      )

    if @following.save
      redirect_to root_path,
                  notice: 'You added a new person to your following list'
    else
      redirect_to root_path,
                  notice: 'Your request has failed'
    end
  end

  def destroy
    @following =
      current_user.followings.find_by(
        user_id: current_user.id,
        following_id: params[:following_id]
      ) 
    @following.destroy
  
    redirect_to root_path, notice: 'Your follow was successfully removed'
  end
end
