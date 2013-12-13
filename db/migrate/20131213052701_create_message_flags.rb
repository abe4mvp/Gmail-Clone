class CreateMessageFlags < ActiveRecord::Migration
  def change
    create_table :message_flags do |t|
      t.integer :message_id, null: false
      t.integer :user_id, null: false
      t.boolean :starred, default: false
      t.boolean :read, default: false
      t.boolean :trashed, default: false

      t.timestamps
    end

    add_index :message_flags, :user_id
    add_index :message_flags, :message_id
  end
end
