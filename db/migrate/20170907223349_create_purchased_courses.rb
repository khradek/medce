class CreatePurchasedCourses < ActiveRecord::Migration
  def change
    create_table :purchased_courses do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
