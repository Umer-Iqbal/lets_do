class CreateConversationables < ActiveRecord::Migration[7.0]
  def change
    create_table :conversationables do |t|
      t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
