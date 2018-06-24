class UsersController < ApplicationController
  before_filter :authorize_admin, only: [:show] #remove once section ready to go live
  
  def show
    @user = User.find(params[:id])
    @courses = @user.courses.where('published = ?', true ).order("title").paginate(:page => params[:page], :per_page => 5)
    @order_item = current_order.order_items.new
    if current_user
      @purchased_courses = current_user.purchased_courses
    else
      @purchased_courses = []
    end
  end

end
