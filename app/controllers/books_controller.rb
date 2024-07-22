class BooksController < ApplicationController

  def index
  end

  def show
  end

  #新規書籍投稿を保存
  def create
    #データを受け取り新規登録するインスタンス作成
    @book = Book.new(book_params)
    #投稿した人（ログイン中のユーザー）のidを格納
    @book.user_id = current_user.id
    #データをデータベースに保存するsaveメソッド実行（不備の確認をしている、なければ保存される）
    @book.save
    #書籍の詳細画面(books/show.html.erb)へリダイレクト
    redirect_to book_path(@book.id)
  end

  def edit
  end

  def update
  end

  #ストロングパラメータ
  private

  def book_params
     params.require(:book).permit(:title, :body)
  end

end
