class Answer < ApplicationRecord
  belongs_to :question

  default_scope { order(created_at: :asc) }

end
