class CreatePostLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :post_likes do |t|
      t.integer :member_id
      t.integer :post_id
      # like = true / hate = false
      t.boolean :like_or_hate
      t.timestamps
    end
  end
end
