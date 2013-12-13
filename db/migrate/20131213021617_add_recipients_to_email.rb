class AddRecipientsToEmail < ActiveRecord::Migration
  def change
    add_column :messages, :recipient_emails, :string
  end
end
