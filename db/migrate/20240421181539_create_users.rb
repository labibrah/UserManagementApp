class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :password_digest
      t.datetime :last_login
      t.datetime :registration_time
      t.string :status

      t.timestamps
    end
  end
end
