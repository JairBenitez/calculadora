Rails.application.routes.draw do
  resources :cotizadores do
    collection do 
      get :exporta_btc
      get :exporta_eth
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'cotizadores#index'
end
