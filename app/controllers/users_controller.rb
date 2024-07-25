class UsersController < ApplicationController

  #ログイン直後の表示されるページ
  def show
    #URLに記載されたIDを参考に必要なUserモデルを取得（ユーザー情報の表示に使用）
    @user = User.find(params[:id])

    #データを受け取り新規登録するインスタンス作成（書籍の新規登録に使用）
    @book = Book.new

    #投稿したBookすべてを表示（書籍の一覧表示に使用）
    @books = Book.all
  end

  #全ユーザーの一覧表示機能
  def index
    #@book.user_id = current_user.id  #空のモデルでは[モデル名].[カラム名]で繋げると保存するカラムの中身を操作できる
    #共通部分で使う変数
    @user = current_user  #投稿者（ログイン中ユーザー）のidを格納
    @book = Book.new
    @books = Book.all


    #登録した全ユーザーの表示（userテーブルに保存されてる全てのデータを取得）
    @users = User.all
  end

  #ユーザー情報の編集機能
  def edit
    #URLを参考に特定のidを持ったレコードを取得
    @user = User.find(params[:id])

    #他人のユーザー情報変更画面に遷移できないようにする
    #unless @user.id == current_user.id
    #  #users/show.html.erbに遷移
    #  redirect_to book_path
    #end
  end

  #更新機能
  def update
    #ユーザーの取得
    @user = User.find(params[:id])
    #ユーザーのアップデート
    if @user.update(user_params)
      #ユーザー情報更新成功のフラッシュメッセージ定義
      flash[:notice] = "You have updated user successfully."
      #更新後、ユーザーの詳細画面(users/show.html.erb)へリダイレクト
      redirect_to user_path(@user.id)
    else
      #edit.html.erbを描画
      render :edit
    end
  end


  #ストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end

end
