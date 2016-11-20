class SorceryCore < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :salt
    end

    add_index :users, :email, unique: true
    rename_column :users, :password, :crypted_password
  end
end