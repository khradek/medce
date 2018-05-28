class CreateMedProfs < ActiveRecord::Migration
  def change
    create_table :med_profs do |t|
      t.string :name
      t.text :about
      t.string :type
      t.string :image
      t.string :phone
      t.string :street
      t.string :city
      t.string :zip
      t.string :state
      t.float :latitude
      t.float :longitude
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
