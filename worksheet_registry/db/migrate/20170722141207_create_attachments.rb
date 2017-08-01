class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.belongs_to :worksheet
      t.string     :original_filename
      t.string     :filename
      t.string     :processed_filename
      t.integer    :state, default: 0

      t.timestamps null: false
    end
  end
end
