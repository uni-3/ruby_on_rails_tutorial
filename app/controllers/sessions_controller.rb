class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # helperより
      log_in @user
      # remember me check boxの挙動
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user

    else
      # ng
      flash.now[:danger] = 'Invalid email/password combination' # 本当は正しくない
      render 'new'
    end
  end

  def destroy
    # helper
    # loginしているときのみおこなう
    log_out if logged_in?
    redirect_to root_url
  end
end
