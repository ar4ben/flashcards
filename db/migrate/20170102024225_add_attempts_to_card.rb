class AddAttemptsToCard < ActiveRecord::Migration
  def change
    add_column :cards, :success, :integer
    add_column :cards, :fail, :integer
  end
end
