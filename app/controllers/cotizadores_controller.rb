class CotizadoresController < ApplicationController

  # GET /cotizadores or /cotizadores.json
  def index
    @monto_usd = 500
    @meses = 12
    @cotizador = Binance.new(@monto_usd, @meses)
  end

  # GET /cotizadores/1 or /cotizadores/1.json
  def show
  end

  # POST /cotizadores or /cotizadores.json
  def create
    @monto_usd = cotizador_params[:monto_usd]
    @meses = cotizador_params[:meses]
    @cotizador = Binance.new(@monto_usd, @meses)
    render :index
  end

  private

  # Solo permite los parámetros listados
  def cotizador_params
    params.permit(:monto_usd, :meses)
  end
end
