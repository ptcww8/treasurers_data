class AddDepositDateToPerformances < ActiveRecord::Migration[5.2]
  def change
    add_column :performances, :deposit_date, :date
  end
end
