class CartsController < ApplicationController

  layout 'personalitza', :only => [:edit, :update, :destroy, :nina]
  before_filter :find_model, :only => [:edit, :update, :destroy, :nina]
  before_filter :store_location
  before_filter :en_construccio

  def en_construccio
    if !session[:intern] 
      render "editNO"
    end
  end

  def index
  end

  def edit
    headers['Content-Type'] = 'application/xhtml+xml'
    logger.info(@cart.inspect)
  end

  def update
    @cart.update_item(@producte, params[:cart_item], 1)
    fer_nina = false
    nina = @producte.coleccio.productes.nina.first
    if @producte.tipus!='nina'
      nina_item = @cart.item(nina)
      if nina_item.quantity==0
        fer_nina = true
      end
    end
    if request.xhr? 
      if fer_nina
        render :json => {:url => nina_cart_path(id: nina.id), :target => 'self'}.to_json
      else 
        render :json => {:url => edit_cart_path, :target => 'parent'}.to_json
      end
    else
      
    end
  end

  def nina
    @vestits = @producte.coleccio.productes.model_nina
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
