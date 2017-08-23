class AddCeHoursToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :ce_hours, :integer
    add_column :courses, :price, :decimal, :precision => 8, :scale => 2 
    add_column :courses, :category1, :string
    add_column :courses, :category2, :string
    add_column :courses, :category3, :string
    add_column :courses, :category4, :string
    add_column :courses, :category5, :string
  end
end
