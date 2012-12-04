class CartsController < ApplicationController

  layout 'personalitza', :only => :edit
  before_filter :find_model, :only => [:edit, :update, :destroy]
  before_filter :store_location

  def index

  end

  def edit
    headers['Content-Type'] = 'application/xhtml+xml'
  end

  def update
    @cart.update_item(@producte, params[:cart_item])
    redirect_to edit_cart_item_path(id: @producte.id)
  end

  def add
    @cart.add(@item, params[:quantity])
    redirect_to cart_path
  end

  def destroy
    @cart.remove @item
    redirect_to cart_path
  end


  def edit_cart
  end

  def update_cart
    @cart.update_cart(params[:cart])
    if params[:refresh] == "0"
      redirect_to shipment_step_cart_path
    elsif params[:refresh] == "1"
      redirect_to cart_path
    end
  end
  
  def validation
    @order = Order.new
    @payment_modes = PaymentMode.with_state(:active)
  end

  private
  def find_model
    if params[:id]
      @producte = Producte.find_by_id(params[:id])
      @item = @cart.item(@producte)
    end
  end
end
