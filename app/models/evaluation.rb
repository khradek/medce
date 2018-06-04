class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :questions, dependent: :destroy
end
