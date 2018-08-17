class AddSlugToMedProf < ActiveRecord::Migration[5.0]
  def change
    add_column :med_profs, :slug, :string
  end
end
