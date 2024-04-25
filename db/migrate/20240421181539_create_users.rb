class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :user do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.datetime :last_login
      t.datetime :registration_time
      t.string :status

      t.timestamps
    end
  end
end
