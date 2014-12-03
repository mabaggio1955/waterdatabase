class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :google_uid
      t.string :name
      t.string :google_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
