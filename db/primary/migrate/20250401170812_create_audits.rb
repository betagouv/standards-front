class CreateAudits < ActiveRecord::Migration[8.0]
  def change
    create_table :audits do |t|
      t.string :startup_uuid, null: false
      t.json :questions

      t.timestamps
    end
  end
end
