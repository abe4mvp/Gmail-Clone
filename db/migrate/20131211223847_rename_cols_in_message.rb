class RenameColsInMessage < ActiveRecord::Migration
  def up
    add_column :messages, :sender, :string
    remove_column :messages, :to
    remove_column :messages, :from
  end

  def down
    remove_column :messages, :sender
    add_column :messages, :to, :string
    add_column :messages, :from, :string
  end
end
