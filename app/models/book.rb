class Book < ApplicationRecord

  #アソシエーションの関係（1:NのN側） 本はユーザーに従属している
  belongs_to :user

  #バリデーション設定
  #presenceは必須入力
  validates :title, presence: true
  #length: {}は文字数について検証、maximum:は最大文字数の設定
  #allow_blank: trueは未入力の場合に無駄な検証をスキップする
  validates :body, presence: true, length: { maximum: 200, allow_blank: true}


end
