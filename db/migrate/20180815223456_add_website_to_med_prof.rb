class AddWebsiteToMedProf < ActiveRecord::Migration[5.0]
  def change
    add_column :med_profs, :website, :string
  end
end

