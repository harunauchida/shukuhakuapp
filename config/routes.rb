Rails.application.routes.draw do  
  # ----------------------------
  # Deviseルート（ログイン・ログアウト・新規登録）
  # ----------------------------
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }

  devise_scope :user do
    post 'logout', to: 'users/sessions#destroy', as: :logout_post
  end

  # ----------------------------
  # トップページ
  # ----------------------------
  root "homes#index"

  # ----------------------------
  # 自分のアカウント情報ページ（表示・編集・更新）
  # ----------------------------
  get   "users/account",      to: "users#account",      as: :user_account
  get   "users/edit_account", to: "users#edit_account", as: :edit_user_account
  patch "users/edit_account", to: "users#update"

  # ----------------------------
  # ユーザーのプロフィールページ（表示）
  # ----------------------------
  resources :users, only: [:show]  # show: プロフィール表示

  # ----------------------------
  # プロフィール編集・更新用ルート（名前付き）
  # ----------------------------
  get   "users/:id/profile_edit", to: "users#edit",   as: :edit_user_profile
  patch "users/:id/profile",      to: "users#update_profile", as: :update_user_profile

  # ----------------------------
  # トップページ用：自分の予約一覧
  # ----------------------------
  resources :reservations, only: [:index]

  # ----------------------------
  # Rooms関連（施設・予約・検索）
  # ----------------------------
  resources :rooms do
    collection do
      get :search
    end

    resources :reservations, only: [:new, :create, :destroy] do
      collection do
        post :confirm
      end
    end
  end
end
