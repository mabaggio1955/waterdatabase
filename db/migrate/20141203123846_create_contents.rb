class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.text :description
      t.string :locale

      t.timestamps
    end
  end
end
