class AddDebtToTreasurers < ActiveRecord::Migration[5.2]
  def change
    add_column :treasurers, :debt, :string
  end
end
