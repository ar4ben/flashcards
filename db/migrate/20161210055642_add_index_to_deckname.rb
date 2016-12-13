class AddIndexToDeckname < ActiveRecord::Migration
  def change
    add_index :decks, [:name, :user_id], unique: true
  end
end
