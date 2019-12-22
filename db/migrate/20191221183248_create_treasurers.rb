class CreateTreasurers < ActiveRecord::Migration[5.2]
  def change
    create_table :treasurers do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :date_of_birth
      t.integer :branch_id
      t.string :council
      t.string :phone_number
      t.string :whatsapp_number
      t.boolean :employment_status, default: false
      t.string :education_level
      t.boolean :born_again
      t.date :ud_join
      t.boolean :bishop_podcast
      t.date :year_treasurer
      t.string :treasurer_type
      t.string :conference
      t.boolean :training_manual
      t.integer :tithe

      t.timestamps
    end
  end
end
