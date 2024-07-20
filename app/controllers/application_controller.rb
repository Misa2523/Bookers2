#全てのコントローラに対する処理を行える権限を持つController

class ApplicationController < ActionController::Base
  #devise利用の機能（ユーザー登録やログイン認証など）が使われる前にメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected   #privateとは違い呼び出された他のコントローラからも参照可能

  #指定したデータを保存できるよう許可を与える
  def configure_permitted_parameters
    #sign_up（ユーザ登録）の時にname（ユーザー名）のデータ操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
