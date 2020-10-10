class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # ok
      # flash変数に代入したメッセージは、リダイレクトした直後のページで表示できるようになります。
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      # ng
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
