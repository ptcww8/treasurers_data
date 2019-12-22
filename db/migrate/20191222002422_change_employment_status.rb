class ChangeEmploymentStatus < ActiveRecord::Migration[5.2]
  def change
		change_column :treasurers, :employment_status, :boolean, default: false
  end
end
