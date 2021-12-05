require 'rest-client'
require 'json'
require 'csv'

# Clase que genera el informe de inversion
# Unitliza la API de api.binance.com
# url definida en config/initializer/api_url.rb
class Binance
  # Constructor de la clase que asigna
  # - monto de inversión
  # - meses de alcance del reporte
  # - crypto monedas para cada reporte
  #
  # Genera los reportes requeridos
  def initialize(monto_usd, meses = 12, tipos = ['btc', 'eth'])
    @monto_usd = monto_usd.to_f
    @meses = meses.to_i
    @tipos = tipos

    genera_informe_de_inversion
  end

  # Precio obtenido de la API
  def precio_bitcoin
    @btc
  end

  # Precio obtenido de la API
  def precio_ethereum
    @eth
  end

  # Obttiene reporte de inversion de Bitcoin
  def info_btc
    @info_btc
  end

  # Obttiene reporte de inversion de Ethereum
  def info_eth
    @info_eth
  end

  # Obtiene el número de meses que comprende el reporte
  def meses
    @meses
  end

  # exporta detalle de inversion Ethereum generada  
  def info_btc_to_csv
    attributes = [
      'Mes',
      'Inversion USD',
      'Bitcoin',
      'Ganancia 5%',
      'Total BTC',
      'Total USD',
      'Acumulado USD'
    ]
 

    CSV.generate(headers: true) do |csv|
      csv << attributes

      (1..@meses).each do |mes|
        csv << [
          mes,
          @monto_usd,
          @info_btc[mes][:monedas],
          @info_btc[mes][:ganancia],
          @info_btc[mes][:total_crypto],
          @info_btc[mes][:total_usd],
          @info_btc[mes][:total_usd_acum]
        ]
      end
    end
  end

  # exporta detalle de inversion Bitcoin generada  
  def info_eth_to_csv
    attributes = [
      'Mes',
      'Inversion USD',
      'Ethereum',
      'Ganancia 3%',
      'Total BTC',
      'Total USD',
      'Acumulado USD'
    ]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      (1..@meses).each do |mes|
        csv << [
          mes,
          @monto_usd,
          @info_eth[mes][:monedas],
          @info_eth[mes][:ganancia],
          @info_eth[mes][:total_crypto],
          @info_eth[mes][:total_usd],
          @info_eth[mes][:total_usd_acum]
        ]
      end
    end
  end

  private

  # Obtiene precios y calcula reporte de ganancias por moneda
  def genera_informe_de_inversion
    @info_btc = {}
    @info_eth = {}
    @mes = 0

    obtiene_precios
    calcula_inversion
  end

  # Obiente precios en USD de moneda
  # aqui se debe agregar la obtención de precios de otras
  # crypto monedas si se requiere en el futuro
  def obtiene_precios
    obtiene_precio_bitcoin
    obtiene_precio_ethereum
  end

  # Función recursiva que calcula la ganancia
  # del mes y moneda
  def calcula_inversion
    if @mes == 0
      @tipo = @tipos.pop
      @total_crypto_acum = 0
      @total_usd_acum = 0
    end
    @mes += 1

    # 1 - Obtiene el precio actual
    precio = obtiene_precio
    # 2 - Calcula número de mondeas que puede comprar
    cryptos = (@monto_usd / precio)
    # 3 - Calcula prcentaje de gananacia cryptomoneda actual
    ganancia_crypto = cryptos * porcentaje_de_ganancia
    # 4 - Calcula total de gananacia en cryptomoneda actual
    total_crypto = cryptos + ganancia_crypto
    # 5 - Calcula total de gananacia en usd
    total_usd = total_crypto * precio

    # 6 - Calcula ganacias de meses acumulados
    @total_crypto_acum += total_crypto
    @total_usd_acum += total_usd

    obj = {
      precio: precio,
      monedas: cryptos,
      ganancia: ganancia_crypto,
      total_crypto: total_crypto,
      total_usd: total_usd,
      total_crypto_acum: @total_crypto_acum,
      total_usd_acum: @total_usd_acum
    }

    @info_btc[@mes] = obj if @tipo == 'btc'
    @info_eth[@mes] = obj if @tipo == 'eth'

    if @mes < @meses
      calcula_inversion
    else
      unless @tipos.empty?
        @mes = 0
        calcula_inversion
      end
    end
  end

  # Devuelve  precio de crypto moneda actual
  def obtiene_precio
    return @btc if @tipo == 'btc'
    return @eth if @tipo == 'eth'

    0
  end

  # Devuelve porcentaje de ganancia  de crypto moneda actual
  def porcentaje_de_ganancia
    return 0.05 if @tipo == 'btc'
    return 0.03 if @tipo == 'eth'

    0
  end

  # Obtiene precio de BITCOIN en DOLARES
  def obtiene_precio_bitcoin
    respuesta = RestClient.get("#{URL_BINANCE}price?symbol=BTCUSDT")
    @btc = JSON.parse(respuesta.to_str)['price'].to_f
  end

  # Obtiene precio de ETHEREUM en DOLARES
  def obtiene_precio_ethereum
    respuesta = RestClient.get("#{URL_BINANCE}price?symbol=ETHUSDT")
    @eth = JSON.parse(respuesta.to_str)['price'].to_f
  end
end
