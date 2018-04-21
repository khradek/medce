class PagesController < ApplicationController

  def masquerade
    if current_user.admin?
      @users = User.all
    end
  end

  def home
    @courses = Course.where('spotlight = ?', true )
    @q = ForumThread.search(params[:q]) #change to query directory
    @forum_threads = ForumThread.limit(2).order('id desc')
    @order_item = current_order.order_items.new
    if current_user
      @purchased_courses = current_user.purchased_courses
    else
      @purchased_courses = []
    end
  end

end