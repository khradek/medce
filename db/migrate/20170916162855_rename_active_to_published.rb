class RenameActiveToPublished < ActiveRecord::Migration
  def change
    rename_column :courses, :active, :published
  end
end
