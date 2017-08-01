class CreateWorksheets < ActiveRecord::Migration[5.0]
  def change
    create_table :worksheets do |t|
      t.integer :decision
      t.boolean :processed, default: false

      t.timestamps null: false
    end
  end
end
