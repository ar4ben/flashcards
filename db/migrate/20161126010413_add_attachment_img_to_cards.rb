class AddAttachmentImgToCards < ActiveRecord::Migration
  def self.up
    change_table :cards do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :cards, :img
  end
end
