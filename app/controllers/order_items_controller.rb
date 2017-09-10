class OrderItemsController < ApplicationController

  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    existing_order = @order.order_items.where(course_id: params[:order_item][:course_id])

    if existing_order.count >= 1
      #stops from adding same course multiple times
      respond_to do |format|
        format.js {render 'already_added.js'}
        format.html { redirect_to cart_path }
      end             
    else
      respond_to do |format|
        if @order.save
          session[:order_id] = @order.id 
          format.html { redirect_to cart_path }
          format.js
        end
      end
    end 
    #session[:order_id] = @order.id 
    #@order_items = @order.order_items    
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    @purchased_courses = current_user.purchased_courses
  end
private
  def order_item_params
    params.require(:order_item).permit(:quantity, :course_id)
  end
end
