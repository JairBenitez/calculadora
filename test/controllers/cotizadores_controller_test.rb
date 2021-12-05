require 'test_helper'

class CotizadoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monto_usd = 500
    @meses = 12
    @cotizador = Binance.new(@monto_usd, @meses)
  end

  test 'debe obtener index' do
    get cotizadores_url
    assert_response :success
  end

  test "should create cotizador" do
    post cotizadores_url, params: { monto_usd: '100', meses: 1 }
    assert_response :success
  end

end
