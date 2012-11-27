class ProductesController < ApplicationController
  def index
    @productes = Producte.all
  end

  def show
    @producte = Producte.find(params[:id])
  end

end
