class BooksController < ApplicationController

  def index
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
    #登録した書籍の詳細画面(books/show.html.erb)へリダイレクト
    redirect_to book_path(@book.id)
  end

  #書籍の編集画面
  def edit
    @book = Book.find(params[:id])
  end

  #書籍の編集画面での更新
  def update
    book = Book.find(params[:id])

    #更新後、書籍の詳細画面(books/show.html.erb)に遷移
    redirect_to books_path
  end

  #ストロングパラメータ
  private

  def book_params
     params.require(:book).permit(:title, :body)
  end

end
