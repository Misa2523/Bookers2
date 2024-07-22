class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      #t.データ型 :カラム名

      #タイトル
      t.string :title
      #オプション
      t.string :body
      #外部キー（#投稿したユーザを識別するID（usersテーブルのidを保存））
      t.integer :user_id

      t.timestamps
    end
  end
end
