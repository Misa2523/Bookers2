class UsersController < ApplicationController

  #ログイン直後の表示されるページ
  def show
    #URLに記載されたIDを参考に必要なUserモデルを取得（ユーザー情報の表示に使用）
    @user = User.find(params[:id])

    ##データを受け取り新規登録するインスタンス作成（書籍の新規登録に使用）
    @book = Book.new

    #投稿したBookすべてを表示（書籍の一覧表示に使用）
    @books = Book.all
  end

  #全ユーザーの一覧表示機能
  def index
    #登録した全ユーザーの表示（userテーブルに保存されてる全てのデータを取得）
    @users = User.all
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
