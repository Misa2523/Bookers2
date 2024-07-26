class BooksController < ApplicationController

  #書籍の一覧画面
  def index
    #共通部分で使う変数
    @user = current_user  #投稿者（ログイン中ユーザー）のidを格納
    @book = Book.new

    #登録した全書籍を格納（booksテーブルに保存されている全てのデータを取得）
    @books = Book.all
    #@usersに書籍の作成者を格納
    @users = User.includes(:books).where(books:{id:@books.pluck(:id)})
    #User.includes(books)は、Userモデルと関連しているBooksモデルも併せて取得
    #where(books:{id:@books.pluck(:id)}は、Booksテーブルのidカラムが、@booksの各書籍IDと一致するUserを取得するための条件
    #↑今回は、@books.pluck(:id)で@booksの各書籍のIDを取得し、それを元にUserを検索してる
  end

  #書籍の詳細画面
  def show
    #書籍の新規登録で使う変数
    @book_new = Book.new

    #URLに含まれるidのBooksモデルを格納
    @book = Book.find(params[:id])
    #書籍の作成者を格納
    @user = @book.user
  end

  #新規書籍投稿を保存
  def create
    #データを受け取り新規登録するインスタンス作成
    @book = Book.new(book_params)
    #投稿した人（ログイン中のユーザー）のidを格納
    @book.user_id = current_user.id
    #データをデータベースに保存するsaveメソッド実行（不備の確認をしている、なければ保存される）
    if @book.save
      #新規投稿成功のフラッシュメッセージ定義
      flash[:notice] = "You have created book successfully."
      #登録した書籍の詳細画面(books/show.html.erb)へリダイレクト
      redirect_to book_path(@book.id)
    else
      #renderでindexアクションを通らずviewページにいくため、indexアクション内で定義しているものをここでも再定義
      @user = current_user
      @books = Book.all

      #index.html.erbを描画
      render :index
    end
  end

  #書籍の編集画面
  def edit
    @book = Book.find(params[:id])

    #private内のメソッド呼び出し（アクセス制限の記述）
    is_matching_login_user
  end

  #書籍の編集画面での更新アクション
  def update
    #更新後にリダイレクトし、変数をViewファイルに渡す必要がない
    #よってbook変数はupdateアクション内だけで使用するため、ローカル変数としている
    @book = Book.find(params[:id])

    #private内のメソッド呼び出し
    is_matching_login_user

    #データ（レコード）を更新
    if @book.update(book_params)
      #書籍更新成功のフラッシュメッセージ定義
      flash[:notice] = "You have updated book successfully."
      #更新後、書籍の詳細画面(books/show.html.erb)へリダイレクト
      redirect_to book_path(@book.id)
    else
      #edit.html.erbを描画
      render :edit
    end
  end

  #書籍の編集画面での削除アクション
  def destroy
    #データ（レコード）を１件取得
    book = Book.find(params[:id])
    #データを削除
    book.destroy
    #削除後、書籍の一覧画面(books/index.html.erb)へリダイレクト
    redirect_to books_path
  end

  #ストロングパラメータ
  private

  def book_params
     params.require(:book).permit(:title, :body)
  end

  #他人の本の情報変更画面に遷移できないようにする
  #ログイン中ユーザーidとURLに含まれるidを比較し、一致しなければユーザー詳細ページに移動する処理
  def is_matching_login_user
    #その本を投稿したユーザーidを取得
    user = User.find(@book.user_id)
    #上記idとログインしてるユーザーidが一致してなかったら
    unless user.id == current_user.id
      #books/index.html.erbに遷移
      redirect_to books_path
    end
  end

end
