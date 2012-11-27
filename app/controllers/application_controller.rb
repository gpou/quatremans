class ApplicationController < ActionController::Base
  before_filter :set_locale
  before_filter :set_locale_from_url
  before_filter :load_cart
  before_filter :store_location
  helper_method :back

  def back
    session[:return_to] || root_path
  end

  private
  
    def set_locale
      I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
#      I18n.locale = params[:locale] || I18n.default_locale
    end

    #def default_url_options(options={})
    #  { :locale => I18n.locale }
    #end

    def store_location
      if params[:controller] == 'carts'
        session[:return_to_cart] = true
      elsif !session[:return_to_cart] || (!(params[:controller].starts_with?'devise') && !(params[:controller].starts_with?'users'))
        session[:return_to_cart] = false
      end
      if params[:controller] != 'carts' && !(params[:controller].starts_with?'devise') && !(params[:controller].starts_with?'users') 
        session[:return_to] = request.fullpath
      end
    end

    def load_cart
      @cart = session[:cart] ||= Cart.new
    end

end
