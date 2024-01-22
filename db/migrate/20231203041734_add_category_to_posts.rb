class AddCategoryToPosts < ActiveRecord::Migration[7.1]
  def change
    change_table :posts do |t|
      t.integer :category, null: false
    end
  end
end
