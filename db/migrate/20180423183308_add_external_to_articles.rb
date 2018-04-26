class AddExternalToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :external, :boolean, null: false, default: false
  end
end
