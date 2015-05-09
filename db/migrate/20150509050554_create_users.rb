class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.string :blood_group
      t.string :area
      t.string :latitude
      t.string :longitude
      t.date :last_donated

      t.timestamps null: false
    end
  end
end
