class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :member_id
      t.string :member_nickname
      t.integer :like_count
      t.integer :hate_count
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
