class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:name, :username, :email, :bg_img, :password, :password_confirmation)
  end

  def acount_update_params
    params.require(:user).permit(:name, :username, :email, :bg_img, :password, :password_confirmation,
                                 :current_password)
  end
end
