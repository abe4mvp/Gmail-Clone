class ChangeStarToHeart < ActiveRecord::Migration
  def change
    rename_column :message_flags, :starred, :heart
  end
end
