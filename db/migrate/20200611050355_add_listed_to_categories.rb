class AddListedToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :listed, :boolean, default: true
  end
end
