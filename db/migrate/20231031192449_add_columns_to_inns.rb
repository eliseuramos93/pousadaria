class AddColumnsToInns < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :description, :string
    add_column :inns, :pet_friendly, :boolean
    add_column :inns, :policy, :string
    add_column :inns, :checkin_time, :time
    add_column :inns, :checkout_time, :time
  end
end
