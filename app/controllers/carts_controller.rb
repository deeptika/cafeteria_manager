class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def index
    @cart = @current_user.carts
    @amount = @cart.map { |item| item.quantity * item.menu_item.menu_item_price }.sum
  end

  def edit
    cart_item = @current_user.carts.find(params[:id])
  end

  def create
    cart = Cart.find_by(user_id: params[:user_id],
                        menu_item_id: params[:menu_item_id])
    if cart == nil
      Cart.create!(
        user_id: params[:user_id],
        menu_item_id: params[:menu_item_id],
        menu_id: params[:menu_id],
        quantity: params[:quantity],
      )
    else
      if params[:quantity].to_i == 0
        cart.destroy
      else
        cart.quantity = params[:quantity]
        cart.save
      end
    end
  end

  def update
    respond_to do |format|
      if @current_user.carts.find(params[:id])
        @cart.update(cart_params)
        if @cart.quantity == 0
          @cart.destroy
        end
        format.html { redirect_to carts_path, notice: "Cart was successfully updated." }
        format.json { render :index, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @current_user.carts.find(params[:id])
      @cart.destroy
      respond_to do |format|
        format.html { redirect_to carts_url, notice: "Menu item  was successfully Removed." }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_cart
    @cart = Cart.find_by(id: params[:id], user_id: @current_user.id)
  end

  def cart_params
    params.require(:cart).permit(:user_id, :menu_item_id, :quantity, :menu_id)
  end
end
