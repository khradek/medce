class RenameProductIdToCourseId < ActiveRecord::Migration
  def change
    rename_column :order_items, :product_id, :course_id
  end
end
