class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body_markdown, null: false
      t.text :body_html, null: false
      t.integer :views, default: 0
      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :slug, unique: true
  end
end
