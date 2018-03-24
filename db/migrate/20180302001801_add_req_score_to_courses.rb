class AddReqScoreToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :req_score, :decimal, precision: 5, scale: 2
  end
end
