require 'rails_helper'

RSpec.describe 'Items Merchants API', type: :request do
  describe 'GET /items/:id/merchants' do
    before :each do
      @item = create(:item)
      @merchant = @item.merchant
      get "/api/v1/items/#{@item.id}/merchants"
    end

    it 'returns the merchant associated with the item' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchant = JSON.parse(response.body, symbolize_names: true)
      merchant_data = merchant[:data]
      expect(merchant).to_not be_empty

      expect(merchant_data).to have_key(:id)
      expect(merchant_data[:id]).to be_a(String)
      expect(merchant_data[:id]).to eq(@merchant.id.to_s)

      expect(merchant_data).to have_key(:attributes)
      expect(merchant_data[:id]).to eq(@merchant.id.to_s)

      expect(merchant_data).to have_key(:type)
      expect(merchant_data[:type]).to be_a(String)

      expect(merchant_data[:attributes]).to have_key(:name)
      expect(merchant_data[:attributes][:name]).to be_an(String)
      expect(merchant_data[:attributes][:name]).to eq(@merchant.name)
    end

    it 'returns error when record does not exist' do
      get "/api/v1/items/0/merchants"
      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find Item with \'id\'=0')
    end
  end
end
