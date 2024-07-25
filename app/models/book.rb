class Book < ApplicationRecord

  #アソシエーションの関係（1:NのN側） 本はユーザーに従属している
  belongs_to :user

  #バリデーション設定
  validates :title, presence: true
  validates :body, presence: true

end
