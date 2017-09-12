class AddPreviewNumToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :preview_num, :integer
    add_column :courses, :category6, :string
  end
end
