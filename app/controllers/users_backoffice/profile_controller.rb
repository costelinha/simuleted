class UsersBackoffice::ProfileController < UsersBackofficeController
  before_action :set_user
  before_action :password_verify , only: [:update]

  def edit
    @user.build_user_profile() if @user.user_profile.blank?
  end

  def update
    if @user.update(params_user)
      bypass_sign_in(@user)
      unless params_user[:user_profile_attributes][:avatar]
        redirect_to users_backoffice_profile_path, notice: "User updated successfully"
      end
    else
      render :edit
    end
  end

  private
    def set_user
      @user = User.find(current_user.id)
    end

    def params_user
     params_user = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
       user_profile_attributes: [:address, :gender, :birthdate, :avatar])
    end

    def password_verify
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].extract!(:password, :password_confirmation)
      end
    end
end
