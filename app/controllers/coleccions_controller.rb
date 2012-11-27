class ColeccionsController < ApplicationController
  def index
    @coleccions = Coleccio.all
  end

  def show
    @coleccio = Coleccio.find(params[:id])
  end
end
