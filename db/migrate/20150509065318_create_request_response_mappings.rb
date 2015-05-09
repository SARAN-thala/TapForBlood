class CreateRequestResponseMappings < ActiveRecord::Migration
  def change
    create_table :request_response_mappings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :blood_request, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
