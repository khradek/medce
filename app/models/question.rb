class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, :allow_destroy => true


  belongs_to :evaluation #just added 2/19


  after_create :set_position

  #Sets the position to 1,000 after create (to have most recently created at bottom of list)
  def set_position
    self.update_attribute(:position, 1000)
  end

end
