require 'rails_helper'

RSpec.describe 'Merchant Search API', type: :request do
  describe 'GET /merchants/find?<attribute>=<value>' do
    before :each do
      create_list(:merchant, 3)
      create(:merchant, name: 'Ring World')
    end
    
    it 'returns single merchant that matches criteria' do
      get '/api/v1/merchants/find?name=ring'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant).to_not be_empty
      merchant_data = merchant[:data]
      expect(merchant.count).to eq(1)

      expect(merchant_data).to have_key(:id)
      expect(merchant_data[:id]).to be_an(String)

      expect(merchant_data).to have_key(:attributes)
      expect(merchant_data[:attributes]).to be_a(Hash)

      expect(merchant_data).to have_key(:type)
      expect(merchant_data[:type]).to be_a(String)
      expect(merchant_data[:type]).to eq('merchant')

      expect(merchant_data[:attributes][:name]).to eq('Ring World')
    end

    xit 'can find merchant using created_at' do
      get '/api/v1/merchants/find?updated_at=44:45.23873'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant).to_not be_empty
      merchant_data = merchant[:data]
      expect(merchant.count).to eq(1)

      expect(merchant_data[:attributes][:name]).to eq('Fahey-Stiedemann')
    end
  end
  # describe 'GET /merchants/find_all?<attribute>=<value>' do
  # before :each do
  #   create_list(:merchant, 3)
  #   create(:merchant, name: 'Ring World')
  #   get '/api/v1/merchants'
  # end
  # end
end
