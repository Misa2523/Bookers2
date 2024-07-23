class BooksController < ApplicationController

  #書籍の一覧画面
  def index
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
    #特定のidのBooksモデルを格納
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
    @book.save
    #登録した書籍の詳細画面(users/show.html.erb)へリダイレクト
    redirect_to user_path(@book.user_id)
  end

  #書籍の編集画面
  def edit
    @book = Book.find(params[:id])
  end

  #書籍の編集画面での更新アクション
  def update
    #更新後にリダイレクトし、変数をViewファイルに渡す必要がない
    #よってbook変数はupdateアクション内だけで使用するため、ローカル変数としている
    book = Book.find(params[:id])
    #データ（レコード）を更新
    book.update(params)
    #更新後、書籍の詳細画面(books/show.html.erb)へリダイレクト
    redirect_to books_path
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

end
