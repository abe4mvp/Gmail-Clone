class AddIndexes < ActiveRecord::Migration
  def change
    add_index :messages, :sender
    add_index :recipients, :message_id
    add_index :recipients, :email_address
  end
end
