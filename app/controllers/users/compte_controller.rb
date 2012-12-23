class Users::CompteController < Devise::RegistrationsController
  prepend_before_filter :authenticate_scope!
  
  def show
  end
end