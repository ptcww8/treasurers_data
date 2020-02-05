class ChangeBranchId < ActiveRecord::Migration[5.2]
  def change
		change_column :performances, :branch_id, :string
  end
end
