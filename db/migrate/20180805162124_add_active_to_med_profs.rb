class AddActiveToMedProfs < ActiveRecord::Migration[5.0]
  def change
    add_column :med_profs, :active, :boolean, null: false, default: false
  end
end
