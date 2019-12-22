class AddUserToTreasurers < ActiveRecord::Migration[5.2]
  def change
    add_column :treasurers, :user_id, :integer
  end
end
