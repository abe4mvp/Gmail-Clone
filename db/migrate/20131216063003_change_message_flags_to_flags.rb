class ChangeMessageFlagsToFlags < ActiveRecord::Migration
  def change
    rename_table :message_flags, :flags
  end
end
