# Description/Explanation of Proyecto class
# frozen_string_literal: true

require('test_helper')

class ActividadTest < ActiveSupport::TestCase
  setup do
    @cotizador = Binance.new(100, 6)
  end

  test 'precio bitcoin' do
    assert_kind_of(Float, @cotizador.precio_bitcoin)
  end

  test 'precio ethereum' do
    assert_kind_of(Float, @cotizador.precio_ethereum)
  end

  test 'meses del reporte' do
    assert_equal(@cotizador.meses, 6)
  end

  test 'meses del reporte bitcoin' do
    assert_equal(@cotizador.info_btc.size, 6)
  end

  test 'meses del reporte ethereum' do
    assert_equal(@cotizador.info_eth.size, 6)
  end
end
