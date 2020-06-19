class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner_or_clerk, only: [:index, :update, :edit]
  before_action :ensure_owner, only: [:report]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.pending_order.order(date: :desc)
    @your_order = false
  end

  def your_orders
    @orders = @current_user.orders.order(date: :desc)
    @your_order = true
    render "index"
  end

  def report
    if (params[:to_date])
      @orders = []
      if (params[:to_date] == "" or params[:from_date] == "")
        flash[:error] = "Date can't be empty"
        redirect_to sales_report_path
      elsif (params[:from_date] > params[:to_date])
        flash[:error] = "Invalid Date range"
        redirect_to sales_report_path
      else
        @from_date = params[:from_date].split("-").join("/")
        @from_date = Date.strptime(@from_date, "%Y/%m/%d")
        @to_date = params[:to_date].split("-").join("/")
        @to_date = Date.strptime(@to_date, "%Y/%m/%d")
        @orders = Order.get_report(params[:from_date], params[:to_date], params[:user_id])
        @totals = OrderItem.group(:order_id).sum(:total)
        @count = @orders.count
        @sum = @orders.map { |item| item.order_items.sum(:total) }.sum
      end
    else
      @orders = Order.all
      @totals = OrderItem.group(:order_id).sum(:total)
      @count = Order.count
      @sum = OrderItem.sum(:total)
    end
  end

  # GET /orders/new
  def new
    if Menu.active
      current_menu_id = Menu.active
    end
    @menu_items = MenuItem.current_menu(current_menu_id)
  end

  # GET /orders/1/edit
  def edit
    @status = @order.status == "preparing"
  end

  def view
    redirect_to carts_path
  end

  # POST /orders
  # POST /orders.json
  def create
    items = @current_user.carts
    type = "walk in"
    type = "Online" if @current_user.is_customer(@current_user.id)
    if items.count > 0
      new_order = Order.create!(
        user_id: @current_user.id,
        date: Time.now.getutc,
        delivered_at: nil,
        status: "confirm",
        order_type: type,
      )
    end

    items.each do |item|
      OrderItem.create!(
        order_id: new_order.id,
        menu_item_id: item.menu_item.id,
        menu_item_name: item.menu_item.menu_item_name,
        menu_item_price: item.menu_item.menu_item_price,
        quantity: item.quantity,
        total: item.quantity * item.menu_item.menu_item_price,
      )
    end
    if items.count > 0
      items.destroy_all
      redirect_to yourorder_path(notice: "Order Successfully placed")
    else
      flash[:error] = "Your Cart is empyt !!"
      redirect_to carts_path
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order.update(status: params[:status])
    @order.save

    if params[:status] == "delivered"
      @order.update(delivered_at: Time.now.utc)
      @order.save
    end

    redirect_to orders_path(notice: "Order Status Updated Successfully ")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:user_id, :date, :delivered_at, :status)
  end
end
