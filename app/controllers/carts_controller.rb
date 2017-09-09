class CartsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @order_items = current_order.order_items
    @purchased_courses = current_user.purchased_courses
  end
  
  def purchase
    @order_items = current_order.order_items
    @order_items.each do |item|
      @purchased_course = current_user.purchased_courses.build
      @purchased_course.update_attribute('course_id', item.course_id)
    end
    session.delete(:order_id)
    current_order.delete
    redirect_to courses_path, notice: 'Thank you for your purchase. Your purchased courses are now available.' 
  end

end
