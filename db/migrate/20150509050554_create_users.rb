class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :string
      t.string :phone_number
      t.string :string
      t.string :blood_group
      t.string :string
      t.string :area
      t.string :string
      t.string :latitude
      t.string :string
      t.string :longitude
      t.string :string
      t.string :last_donated
      t.string :date

      t.timestamps null: false
    end
  end
end
