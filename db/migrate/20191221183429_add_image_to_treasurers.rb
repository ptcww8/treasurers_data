class AddImageToTreasurers < ActiveRecord::Migration[5.2]
  def change
    add_column :treasurers, :image, :string
  end
end
