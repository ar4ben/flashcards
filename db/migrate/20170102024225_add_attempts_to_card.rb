class AddAttemptsToCard < ActiveRecord::Migration
  def change
    add_column :cards, :success, :int
    add_column :cards, :fail, :int
  end
end
