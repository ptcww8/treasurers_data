class AddDebtReasonToTreasurers < ActiveRecord::Migration[5.2]
  def change
    add_column :treasurers, :debt_reason, :text
  end
end
