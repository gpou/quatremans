class ApplicationController < ActionController::Base
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

end
