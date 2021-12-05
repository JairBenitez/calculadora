require "application_system_test_case"

class CotizadoresTest < ApplicationSystemTestCase
  setup do
    @cotizador = cotizadores(:one)
  end

  test "visiting the index" do
    visit cotizadores_url
    assert_selector "h1", text: "Cotizadores"
  end

  test "creating a Cotizador" do
    visit cotizadores_url
    click_on "New Cotizador"

    click_on "Create Cotizador"

    assert_text "Cotizador was successfully created"
    click_on "Back"
  end

  test "updating a Cotizador" do
    visit cotizadores_url
    click_on "Edit", match: :first

    click_on "Update Cotizador"

    assert_text "Cotizador was successfully updated"
    click_on "Back"
  end

  test "destroying a Cotizador" do
    visit cotizadores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cotizador was successfully destroyed"
  end
end
