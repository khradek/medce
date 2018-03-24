class CreateEvalResults < ActiveRecord::Migration
  def change
    create_table :eval_results do |t|
      t.integer :course_id
      t.integer :user_id
      t.decimal :score, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
