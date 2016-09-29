class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email
      t.text :password

      t.timestamps null: false
    end
    add_column :cards, :user_id, :integer
  end
end
