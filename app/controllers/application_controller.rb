class ApplicationController < ActionController::Base
  before_filter :set_locale
  before_filter :set_locale_from_url
  protect_from_forgery
  include SessionsHelper

  private
  
    def admin_user
      if !current_user || !current_user.admin? then
        flash[:error] = "Si et plau, identifica't per poder accedir a aquesta pagina."
        session[:return_to] = request.url
        redirect_to(signin_path)
      end
    end

    def set_locale
      I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
#      I18n.locale = params[:locale] || I18n.default_locale
    end

    #def default_url_options(options={})
    #  { :locale => I18n.locale }
    #end
end
