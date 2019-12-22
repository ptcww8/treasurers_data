class AddCommentsToTreasurers < ActiveRecord::Migration[5.2]
  def change
    add_column :treasurers, :comments, :text
  end
end
