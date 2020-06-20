class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner
  skip_before_action :ensure_owner, only: [:index]

  def index
    @menus = Menu.all
    @current_menu_id = Menu.active()
    @current_menu_id = params[:current_menu_id] if params[:current_menu_id]
    @menu_items = MenuItem.current_menu(@current_menu_id)
  end

  def show
    @current_menu_id = params[:current_menu_id] if params[:current_menu_id]
  end

  def new
    @menu_item = MenuItem.new
    @current_menu_id = params[:current_menu_id] if params[:current_menu_id]
  end

  def edit
    @current_menu_id = params[:current_menu_id] if params[:current_menu_id]
  end

  def create
    menu_item = MenuItem.create(
      menu_id: params[:menu_id],
      menu_item_name: params[:menu_item_name],
      menu_item_price: params[:menu_item_price],
    )
    if menu_item.save
      redirect_to menu_items_path(
        :current_menu_id => params[:menu_id],
        :notice => "Menu item was successfully added.",
      )
    else
      flash[:error] = menu_item.errors.full_messages.join(", ")
      redirect_to new_menu_item_path(:current_menu_id => params[:menu_id])
    end
  end

  def update
    menu_id = params[:current_menu_id]
    respond_to do |format|
      if @menu_item.update(menu_item_params)
        format.html {
          redirect_to :action => "show",
                      current_menu_id: menu_id,
                      notice: "Menu item was successfully updated."
        }
        format.json { render :show, status: :ok, location: @menu_item }
      else
        format.html { render :edit }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu_item.destroy
    respond_to do |format|
      format.html {
        redirect_to action: "index",
                    current_menu_id: params[:current_menu_id],
                    notice: "Menu item was successfully Removed."
      }
      format.json { head :no_content }
    end
  end

  private

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:menu_id, :menu_item_name, :menu_item_price, :image_url)
  end
end
