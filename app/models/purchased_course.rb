class PurchasedCourse < ApplicationRecord
  belongs_to :user

  def matching_course
    matching_course = Course.find_by(id: self.course_id)
  end
end
