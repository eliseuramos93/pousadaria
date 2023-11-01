class CreateInns < ActiveRecord::Migration[7.1]
  def change
    create_table :inns do |t|
      t.string :brand_name
      t.string :registration_number
      t.string :phone_number

      t.timestamps
    end
  end
end
