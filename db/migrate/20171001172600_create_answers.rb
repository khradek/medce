class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text
      t.integer :question_id
      t.boolean :correct_answer, null: false, default: false

      t.timestamps null: false
    end
  end
end
