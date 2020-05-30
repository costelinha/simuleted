class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]
  before_action :password_verify, only: [:update]

  def index
    @admins = Admin.all.page params[:page]
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save()
      redirect_to admins_backoffice_admins_path, notice: "Administrator created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Administrator updated successfully"
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy()
      redirect_to admins_backoffice_admins_path, notice: "Administrator deleted successfully"
    else
      render :edit
    end
  end

  private
  def password_verify
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def params_admin
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
