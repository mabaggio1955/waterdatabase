class RenameNameToSlugFromCategories < ActiveRecord::Migration
  def up
    rename_column :categories, :name, :slug
    remove_column :categories, :locale
    Category.reset_column_information
    Category.destroy_all
    Category.create_defaults!
    default_category = Category.first
    Content.find_each do |content|
      content.category = default_category
      content.save!
    end
  end
end
