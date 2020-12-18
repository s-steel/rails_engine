require 'rails_helper'

RSpec.describe 'Merchant Items API', type: :request do
  describe 'GET /merchants/:id/items' do
    before :each do
      @merchant = create(:merchant, :with_items)
      @merchant2 = create(:merchant, :with_items)
      @other_item = @merchant2.items.first
      @other_item[:name] = 'asdfg'
      @other_item[:description] = 'xcvbnm'
      @other_item[:unit_price] = 100_000
    end

    it 'sends list of all items from one merchant' do
      get "/api/v1/merchants/#{@merchant.id}/items"
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      items = JSON.parse(response.body, symbolize_names: true)
      items_data = items[:data]
      expect(items).to_not be_empty
      expect(items_data.count).to eq(5)

      items_data.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        expect(item[:id]).to_not eq(@other_item.id.to_s)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_an(String)
        expect(item[:attributes][:name]).to_not eq(@other_item.name)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_an(String)
        expect(item[:attributes][:description]).to_not eq(@other_item.description)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes][:unit_price]).to_not eq(@other_item.unit_price)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
        expect(item[:attributes][:merchant_id]).to_not eq(@other_item.merchant_id)
      end
    end

    it 'returns error when record does not exist' do
      get '/api/v1/merchants/0/items'
      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find Merchant with \'id\'=0')
    end
  end
end
