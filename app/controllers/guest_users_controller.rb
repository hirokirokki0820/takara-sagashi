class GuestUsersController < ApplicationController

  def new
  end

  def create
    @user = User.new
    @user.set_guest_user_id
    @user.name = "Guest"
    @user.guest = true
    if @user.save
      log_in @user
      flash[:notice] = "こんにちは、#{@user.name}さん"
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, status: :see_other
  end

  private

    # ランダムなユーザーID生成
    def set_guest_user_id
      while self.id.blank? || User.find_by(id: self.id).present? do
        self.id = SecureRandom.base36
      end
    end
    # def guest_params
    #   params.require(:user).permit(:name)
    # end
end
