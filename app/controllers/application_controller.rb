#全てのコントローラに対する処理を行える権限を持つController

class ApplicationController < ActionController::Base
  #before_action：devise利用の機能（ユーザー登録やログイン認証など）が使われる前にメソッドを実行
  # top, about の2つのアクションのみ、ログイン無しでもアクセス可能にする
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

   #ログイン直後ユーザーの詳細ページに遷移(showアクション実行)
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  protected   #privateとは違い呼び出された他のコントローラからも参照可能

  #指定したデータを保存できるよう許可を与える
  def configure_permitted_parameters
    #sign_up（ユーザ登録）の時にname（ユーザー名）のデータ操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
