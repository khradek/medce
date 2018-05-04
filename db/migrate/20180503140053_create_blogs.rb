class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.string :author
      t.integer :user_id
      t.string :category
      t.boolean :published, null: false, default: false
      t.boolean :spotlight, null: false, default: false
      t.string :image

      t.timestamps null: false
    end
  end
end
