class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :nickname
      t.string :user_role
      t.timestamps
    end
  end
end
