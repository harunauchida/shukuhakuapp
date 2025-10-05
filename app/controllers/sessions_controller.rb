class SessionsController < ApplicationController
  def new
    # ログインフォーム表示用
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています"
      render :new
    end
  end

  def destroy_get
    sign_out(current_user)
    redirect_to root_path, notice: "ログアウトしました"
  end
end
