class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @cart = Cart.joins(:menu_item).where(user_id: @current_user.id)
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.joins(:menu_item).where(user_id: @current_user.id)
  end

  # GET /carts/1/edit
  def edit
    cart_item = Cart.find(params[:id])

    unless cart_item.user_id == @current_user.id
      redirect_to carts_path
    end
  end

  # POST /carts
  # POST /carts.json
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

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart
        @cart.update(cart_params)
        format.html { redirect_to carts_path, notice: "Cart was successfully updated." }
        format.json { render :index, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @cart
      @cart.destroy
      respond_to do |format|
        format.html { redirect_to carts_url, notice: "Menu item  was successfully Removed." }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = Cart.find_by(id: params[:id], user_id: @current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.require(:cart).permit(:user_id, :menu_item_id, :quantity, :menu_id)
  end
end
