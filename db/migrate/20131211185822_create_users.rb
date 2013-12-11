class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash

      t.timestamps
    end
    add_index :users, [:email, :password_hash]
    add_index :users, :email
  end
end
