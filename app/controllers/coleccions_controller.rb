class ColeccionsController < ApplicationController
  def index
    redirect_to coleccio_path(Coleccio.first)
  end

  def show
    @coleccio = Coleccio.find(params[:id])
  end
end
