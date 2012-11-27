class StaticPagesController < ApplicationController
  
  layout 'home', :only => :home
  def home
  end

  def quisom
  end

  def contacte
  end

  def condicionscompra
  end
end
