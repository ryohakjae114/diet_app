class DeviseCreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      ## Database authenticatable
      t.string :name,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Rememberable
      t.datetime :remember_created_at


      t.timestamps null: false
    end

    add_index :admins, :name,                unique: true
    # add_index :admins, :confirmation_token,   unique: true
    # add_index :admins, :unlock_token,         unique: true
  end
end
