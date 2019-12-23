class AddVerifiedToTreasurers < ActiveRecord::Migration[5.2]
  def change
    add_column :treasurers, :verified, :boolean, default: false
  end
end
