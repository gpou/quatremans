# encoding: utf-8
class CartsController < ApplicationController

  layout 'personalitza', :only => [:edit, :nina, :update, :destroy]
  before_filter :find_model, :only => [:edit, :update, :destroy, :nina]
  before_filter :store_location
  before_filter :en_construccio
  before_filter :require_cart, :only => [:order_cart, :validation_cart]

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


  def destroy
    @cart.remove @item
    redirect_to edit_cart_path
  end


  def edit_cart
  end

  def shipment_address_cart
    if current_user && current_user.addresses.shipment.any? && !@cart.shipment_address
      @address = current_user.addresses.shipment.first.clone
      @address.is_invoice = false
    elsif !@cart.shipment_address
      @address = Address.new
      @address.country_id = 67
      @address.provincia_id = 19
    else 
      @address = @cart.shipment_address
    end
  end

  def save_shipment_address_cart
    @address = Address.new params[:address]
    if @address.valid?
      @cart.shipment_address = @address
      @cart.calculate_shipping_amount
      redirect_to invoice_address_cart_path
    else
      render :shipment_address_cart
    end
  end

  def invoice_address_cart
    if current_user && current_user.addresses.invoice.any? && !@cart.invoice_address
      @address = current_user.addresses.invoice.first.clone
      @address.is_invoice = true
    elsif !@cart.invoice_address
      @address = Address.new
      @address.country_id = 67
      @address.provincia_id = 19
    else
      @address = @cart.invoice_address
    end
  end

  def save_invoice_address_cart
    @address = Address.new params[:address]
    @address.is_invoice = true
    if @address.valid?
      @cart.invoice_address = @address
      redirect_to validation_cart_path
    else
      render :invoice_address_cart
    end
  end

  def validation_cart
    @payment_modes = Paymentmode.with_state(:active)
  end

  def order_cart
    continue = true
    if params[:order][:crear_usuari] && params[:order][:crear_usuari]=="1"
      if @cart.invoice_address.email.empty?
        flash[:error] = "Per crear un usuari amb les teves dades, cal que introdueixis una adreça mail"
        redirect_to invoice_address_cart_path
        continue = false
      else
        user = User.new
        user.email = @cart.invoice_address.email
        user.password = ('0'..'z').to_a.shuffle.first(8).join
        user.first_name = @cart.invoice_address.first_name
        user.last_name = @cart.invoice_address.last_name
        if user.save
          sign_in user
        else
          @error = user.errors.full_messages
          @payment_modes = Paymentmode.with_state(:active)
          render :validation_cart
          continue = false
        end
      end
    end
    if continue
      @order = Order.new params[:order]
      if @order.valid?
        @order.save_cart(@cart)
        session[:cart] = nil

        reference = @order.number
        @transaction = Ordertransaction.create :order => @order, :amount => @order.amount, :reference => reference

        #UserMailer.order_notification(current_user,@order,account_order_url(@order)).deliver
        if current_user
          @order.user = current_user
          @order.save
          current_user.addresses.delete_all
          address = @order.addresses.shipment.first.clone
          current_user.addresses << address
          address = @order.addresses.invoice.first.clone
          current_user.addresses << address
        else
          session[:comanda] = @order.id
        end
        redirect_to transferencia_order_path(@order) if @order.paymentmode.slug == 'transferencia'
        redirect_to tarjeta_order_path(@order) if @order.paymentmode.slug == 'tarjeta'
      else
        @error = t('carts.seleccioneu_forma_pagament')
        @payment_modes = Paymentmode.with_state(:active)
        render :validation_cart
      end
    end
  end

  private

    def find_model
      if params[:id]
        @producte = Producte.find_by_id(params[:id])
        @item = @cart.item(@producte)
      end
    end

    def require_cart
      redirect_to edit_cart_path unless @cart.items.any?
    end
end
