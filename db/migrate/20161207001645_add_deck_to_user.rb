class AddDeckToUser < ActiveRecord::Migration
  def change
    add_reference :users, :deck, index: true, foreign_key: true
  end
end
