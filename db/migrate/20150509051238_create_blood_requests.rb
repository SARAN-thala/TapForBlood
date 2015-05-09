class CreateBloodRequests < ActiveRecord::Migration
  def change
    create_table :blood_requests do |t|
      t.string :blood_group
      t.string :latitude
      t.string :longitude
      t.string :area
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
