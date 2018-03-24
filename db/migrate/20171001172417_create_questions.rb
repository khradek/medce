class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.integer :evaluation_id

      t.timestamps null: false
    end
  end
end