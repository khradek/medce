class RenameAuthorIdToUserId < ActiveRecord::Migration
  def change
    rename_column :courses, :author_id, :user_id
  end
end
