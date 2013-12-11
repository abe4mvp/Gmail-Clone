class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.integer :message_id
      t.string :email_address

      t.timestamps
    end
  end
end
