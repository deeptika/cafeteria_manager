class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.get_items(params[:order_id])
    @amount = OrderItem.get_total(params[:order_id])
    @user_data = Order.get_details(params[:order_id])
  end
end
