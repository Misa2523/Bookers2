#全てのコントローラに対する処理を行える権限を持つController

class ApplicationController < ActionController::Base
  #before_action：devise利用の機能（ユーザー登録やログイン認証など）が使われる前にメソッドを実行
  # top, about の2つのアクションのみ、ログイン無しでもアクセス可能にする
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  #フラッシュメッセージはもともとの機能であるため定義しなくてよい（viewページの方に書くだけ）

  #ログイン直後に実行される
  def after_sign_in_path_for(resource)
    #ユーザーの詳細ページに遷移(showアクション実行)
    user_path(current_user)
  end

  #サインアウト直後に実行される
  def after_sign_out_path_for(resource)
    #トップ画面に遷移
    root_path
  end

  protected   #privateとは違い呼び出された他のコントローラからも参照可能

  #指定したデータを保存できるよう許可を与える
  def configure_permitted_parameters
    #サインアップ（新規登録）時にemailを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
