class AddSundayDateToPerformances < ActiveRecord::Migration[5.2]
  def change
    add_column :performances, :sunday_service, :date
  end
end
