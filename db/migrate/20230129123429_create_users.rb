class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, null: false
      t.string :full_name
      t.string :bio
      t.string :profile_picture
      t.string :cover_photo
      t.integer :followers_count, default: 0
      t.integer :followings_count, default: 0
      t.integer :posts_count, default: 0

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
