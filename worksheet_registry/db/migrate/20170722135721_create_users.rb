class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string   :first_name
      t.string   :second_name
      t.string   :login,    null: false
      t.string   :password, null: false
      t.string   :token,    null: false

      t.timestamps null: false
    end

    add_index :users, :login, unique: true
    add_index :users, :token, unique: true
  end
end
