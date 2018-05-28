class ChangeNameToTitle < ActiveRecord::Migration
  def change
    rename_column :med_profs, :type, :med_prof_type
    rename_column :med_profs, :name, :title
  end
end

