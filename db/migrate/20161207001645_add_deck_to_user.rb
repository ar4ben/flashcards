class AddDeckToUser < ActiveRecord::Migration
  def change
    add_index :deck, [:name, :user_id], unique: true
  end
end
