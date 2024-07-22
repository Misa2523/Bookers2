class Book < ApplicationRecord

  #アソシエーションの関係（1:NのN側） 本はユーザーに従属している
  belongs_to :user

end
