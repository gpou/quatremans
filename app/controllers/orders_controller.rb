# encoding: utf-8
class OrdersController < ApplicationController

  before_filter :find_model, :except => %w(index)
  before_filter :verify_user, :except => %w(index)
  before_filter :authenticate_user!, :only => "index"
  
  #helper :paiement_cic

  def show

  end

  def tarjeta_order

  end

  def transferencia_order

  end

  def rebut_order
    respond_to do |format|
      format.pdf {
        render :pdf => "rebut", 
          :layout => 'pdf', 
          :show_as_html => params[:debug], 
          :margin => {:top => 50, :bottom => 20, :left => 20, :right => 20 },
          :disable_internal_links => true,
          :header => {
            :html => { 
              :template => 'orders/rebut_order_header', 
              :layout => 'pdf',
              :locals => { :order => @order }
            },
            :spacing => 40
          },
          :footer => {
            :html => { 
              :template => 'orders/rebut_order_footer', 
              :layout => 'pdf'
            },
            :spacing => 10
          },
          :save_to_file => Rails.root.join('pdfs', "comanda_#{@order.number}.pdf")
      }
    end
  end


  private
    def find_model
      @order = Order.find params[:id]
      @transaction = @order.ordertransactions.last
    end

    def verify_user
      ok = false
      if current_user && current_user==@order.user
        ok = true
      elsif session[:comanda] == @order.id
        ok = true
      end
      if !ok
        redirect_to signin_path
      end
    end
end
