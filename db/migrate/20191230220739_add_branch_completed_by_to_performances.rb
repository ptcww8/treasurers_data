class AddBranchCompletedByToPerformances < ActiveRecord::Migration[5.2]
  def change
    add_column :performances, :branch_id, :integer
    add_column :performances, :completed_by, :integer
  end
end
