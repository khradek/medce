class AddSpotlightToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :spotlight, :boolean, null: false, default: false
  end
end
