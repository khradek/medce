class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.text :body
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
