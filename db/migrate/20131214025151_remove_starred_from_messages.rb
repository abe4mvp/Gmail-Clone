class RemoveStarredFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :starred
  end
end
