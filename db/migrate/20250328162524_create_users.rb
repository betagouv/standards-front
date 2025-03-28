class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :uuid, null: false
      t.string :fullname, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
