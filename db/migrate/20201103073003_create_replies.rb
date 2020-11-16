class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.integer :member_id
      t.integer :post_id
      t.string :member_nickname
      t.string :content
      t.timestamps
    end
  end
end
