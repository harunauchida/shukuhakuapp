class UsersController < ApplicationController   
  before_action :authenticate_user!
  # ID が必要なアクション（プロフィール表示や編集）だけに set_user を使う
  before_action :set_user, only: [:show, :edit]

# current_user を使うアクション（アカウント編集や更新）専用
  before_action :set_current_user, only: [:edit_account, :update]


  # 新規ユーザー作成用
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new
    end
  end

  # 個別ユーザー表示
  def show
    @user = User.find(params[:id])
  end

  # 編集画面（ID指定）
  def edit
  end

  # アカウント情報表示（自分専用）
  def account
    @user = current_user
  end

  # アカウント情報編集（自分専用）
  def edit_account
    @user = current_user
  end

  # プロフィール編集画面
  def profile
    @user = current_user
  end

  # アカウント情報更新
  def update
    @user ||= current_user

    if @user.update(user_params)
      redirect_to user_account_path, notice: "アカウント情報を更新しました"
    else
      if params[:return_to] == "edit_account"
        render :edit_account
      else
        render :edit
      end
    end
  end

  # プロフィール更新
  def update_profile
  @user = current_user

  if @user.update(user_params)
    redirect_to user_path(@user), notice: "プロフィール情報を更新しました"
    else
    render :profile
    end
  end

  private

  # ID指定でユーザー取得（show, edit, update 用）
  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
  @user = current_user
  end

  def user_params
    permitted = [:name, :email, :icon, :profile]
    permitted << :password << :password_confirmation if params[:user][:password].present?
    params.require(:user).permit(permitted)
  end
end
