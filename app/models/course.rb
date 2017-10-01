class Course < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :evaluation, dependent: :destroy

  after_create :create_evaluation

  def create_evaluation
    Evaluation.create :course_id => self.id, :user_id => self.user_id, :course_id => self.id
  end

end
