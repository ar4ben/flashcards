class AddEfQualityRepetitionToCard < ActiveRecord::Migration
  def change
    add_column :cards, :ef, :float, default: 2.5
    add_column :cards, :quality, :integer
    add_column :cards, :repetition, :integer, default: 1
  end
end
