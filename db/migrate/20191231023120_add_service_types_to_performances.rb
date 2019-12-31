class AddServiceTypesToPerformances < ActiveRecord::Migration[5.2]
  def change
    add_column :performances, :service_type, :integer
  end
end
