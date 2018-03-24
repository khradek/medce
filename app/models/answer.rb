class Answer < ActiveRecord::Base
  belongs_to :question

  default_scope { order(created_at: :asc) }

end
