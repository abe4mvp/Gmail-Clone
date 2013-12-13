class CreateMessageFlags < ActiveRecord::Migration
  def change
    create_table :message_flags do |t|

      t.timestamps
    end
  end
end
