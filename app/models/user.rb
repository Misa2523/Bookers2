class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #deviseで使用する機能
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーションの関係（1:Nの1側）
  has_many :books, dependent: :destroy
  #dependent: :destroy → 1:Nの1側が削除されたとき、N側を全て削除する

  #profile_imageという名前で、ActiveStorageでプロフィール画像を保存できるよう設定
  has_one_attached :profile_image

  #バリデーション設定
  validates :name, presence: true

  #画像が投稿されない場合のエラー回避
  #アクションと違い、特定の処理を名前で呼び出す
  def get_profile_image(width, height)
    unless profile_image.attached?
      #画像が設定されない場合はapp/assets/imagesに格納されているdefault-image.jpgを
          #デフォルト画像としてActiveStorageに格納し、格納した画像を表示する
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    #画像サイズ変更（引数width, heightを設定）：画像をwidth×heightのサイズに変換する
    profile_image.variant(resize_to_limit: [width, height]).processed
    # ↑このメソッドを実行する際get_profile_image(100, 100)のように引数を設定すると100x100の画像にリサイズされる
  end


end
