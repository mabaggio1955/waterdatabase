class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.attachment :file
      t.belongs_to :content, index: true

      t.timestamps
    end
  end
end
