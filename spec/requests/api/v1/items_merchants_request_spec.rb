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
      expect(merchant).to_not be_empty

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)
      expect(merchant[:id]).to eq(@merchant.id)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_an(String)
      expect(merchant[:name]).to eq(@merchant.name)

      expect(merchant).to have_key(:created_at)
      expect(merchant[:created_at]).to be_an(String)

      expect(merchant).to have_key(:updated_at)
      expect(merchant[:updated_at]).to be_an(String)
    end

    it 'returns error when record does not exist' do
      get "/api/v1/items/0/merchants"
      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find Item with \'id\'=0')
    end
  end
end
