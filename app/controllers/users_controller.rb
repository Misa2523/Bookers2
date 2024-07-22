class UsersController < ApplicationController

  #ログイン直後の表示されるページ
  def show
    #URLに記載されたIDを参考に必要なUserモデルを取得
    @user = User.find(params[:id])
  end

  def index
  end

  #ユーザー情報の編集機能
  def edit
    #URLを参考に特定のidを持ったレコードを取得
    @user = User.find(params[:id])
  end

  #更新機能
  def update
    #ユーザーの取得
    @user = User.find(params[:id])
    #ユーザーのアップデート
    @user.update(user_params)
    #ユーザーの詳細ページへ遷移
    redirect_to user_path(@user.id)
  end


  #ストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end

end
