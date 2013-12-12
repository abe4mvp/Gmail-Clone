class AddRecipientId < ActiveRecord::Migration
  def change
    add_column :recipients, :recipient_id, :integer
  end

end
