class AddSenderIdtoMessage < ActiveRecord::Migration
  def change
    add_column :messages, :sender_id, :integer
  end

end
