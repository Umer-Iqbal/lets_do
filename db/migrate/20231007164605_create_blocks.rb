class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.references :user, foreign_key: { to_table: :users }, null: false
      t.references :blocked_user, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
