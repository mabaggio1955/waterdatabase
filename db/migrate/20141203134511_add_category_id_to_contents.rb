class AddCategoryIdToContents < ActiveRecord::Migration
  def change
    add_reference :contents, :category, index: true
  end
end
