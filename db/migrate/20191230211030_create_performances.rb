class CreatePerformances < ActiveRecord::Migration[5.2]
  def change
    create_table :performances do |t|
      t.string :who_came
      t.string :who_counted
      t.string :when_counted
      t.string :when_paid
      t.string :who_paid

      t.timestamps
    end
  end
end
