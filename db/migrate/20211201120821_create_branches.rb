class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.string :branch
      t.string :council

      t.timestamps
    end
  end
end
