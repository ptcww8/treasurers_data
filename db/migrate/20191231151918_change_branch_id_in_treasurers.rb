class ChangeBranchIdInTreasurers < ActiveRecord::Migration[5.2]
  def change
		change_column :treasurers, :branch_id, :string
  end
end
