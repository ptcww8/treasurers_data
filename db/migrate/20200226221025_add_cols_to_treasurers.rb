class AddColsToTreasurers < ActiveRecord::Migration[5.2]
  def change
    add_column :treasurers, :holy_ghost, :boolean
    add_column :treasurers, :quiet_time, :boolean
    add_column :treasurers, :baptism, :boolean
  end
end
