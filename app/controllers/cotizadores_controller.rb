class CotizadoresController < ApplicationController
  # GET /cotizadores or /cotizadores.json
  def index
    @monto_usd = 500
    @meses = 12
    @cotizador = Binance.new(@monto_usd, @meses)
  end
  
  # POST /cotizadores or /cotizadores.json
  def create
    @monto_usd = cotizador_params[:monto_usd]
    @meses = cotizador_params[:meses]
    @cotizador = Binance.new(@monto_usd, @meses)
   
    render :index
  end

  # GET /cotizadores/exporta_btc
  def exporta_btc
    @monto_usd = cotizador_params[:monto_usd]
    @meses = cotizador_params[:meses]
    @cotizador = Binance.new(@monto_usd, @meses)
    
    respond_to do |format|
      format.html { render :index }
      format.csv {
        send_data(
          @cotizador.info_btc_to_csv,
          filename: "cotizacion-#{Date.today}.csv"
        )
      }
      format.json {
        send_data(
          @cotizador.info_btc.to_json,
          filename: "cotizacion-btc-#{Date.today}.json"
        )
      }
    end
  end

  # GET /cotizadores/exporta_eth
  def exporta_eth
    @monto_usd = cotizador_params[:monto_usd]
    @meses = cotizador_params[:meses]
    @cotizador = Binance.new(@monto_usd, @meses)
    
    respond_to do |format|
      format.html { render :index }
      format.csv {
        send_data(
          @cotizador.info_eth_to_csv,
          filename: "cotizacion-#{Date.today}.csv"
        )
      }
      format.json {
        send_data(
          @cotizador.info_eth.to_json,
          filename: "cotizacion-eth-#{Date.today}.json"
        )
      }
    end
  end


  private

  # Solo permite los parámetros listados
  def cotizador_params
    params.permit(:monto_usd, :meses)
  end
end
