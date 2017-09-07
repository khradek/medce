class OrderItem < ActiveRecord::Base
  belongs_to :course
  belongs_to :order

  before_validation :set_quantity
  #validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :course_present
  validate :order_present

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      course.price
    end
  end

  def total_price
    unit_price * quantity
  end

private
  def course_present
    if course.nil?
      errors.add(:course, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end

  def set_quantity
    self[:quantity] = 1
  end
end
