class AddCategoryToForumThreads < ActiveRecord::Migration
  def change
    add_column :forum_threads, :category, :string
  end
end
