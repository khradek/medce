class Course < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_one :evaluation, dependent: :destroy
  has_many :eval_results
  validates :req_score, :inclusion => 0..100, allow_nil: true
  validates :price, :ce_hours, :title, :req_score, presence: true

  after_create :create_evaluation

  def create_evaluation
    Evaluation.create :course_id => self.id, :user_id => self.user_id
  end

  def passed?(id)
    eval_results = EvalResult.where(course_id: self.id, user_id: id)
    c = 0 
    eval_results.each do |r|
      if r.score >= self.req_score
        c += 1 
      end
    end
    c > 0
  end

end
