require 'test_helper'

class CotizadoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cotizador = cotizadores(:one)
  end

  test "should get index" do
    get cotizadores_url
    assert_response :success
  end

  test "should get new" do
    get new_cotizador_url
    assert_response :success
  end

  test "should create cotizador" do
    assert_difference('Cotizador.count') do
      post cotizadores_url, params: { cotizador: {  } }
    end

    assert_redirected_to cotizador_url(Cotizador.last)
  end

  test "should show cotizador" do
    get cotizador_url(@cotizador)
    assert_response :success
  end

  test "should get edit" do
    get edit_cotizador_url(@cotizador)
    assert_response :success
  end

  test "should update cotizador" do
    patch cotizador_url(@cotizador), params: { cotizador: {  } }
    assert_redirected_to cotizador_url(@cotizador)
  end

  test "should destroy cotizador" do
    assert_difference('Cotizador.count', -1) do
      delete cotizador_url(@cotizador)
    end

    assert_redirected_to cotizadores_url
  end
end
