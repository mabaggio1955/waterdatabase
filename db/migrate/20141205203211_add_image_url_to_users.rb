class AddImageUrlToUsers < ActiveRecord::Migration
  def change
    User.destroy_all
    add_column :users, :image_url, :string
  end
end
