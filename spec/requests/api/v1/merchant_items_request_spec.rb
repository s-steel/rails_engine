require 'rails_helper'

RSpec.describe 'Merchant Items API', type: :request do
  describe 'GET /merchants/:id/items' do
    before :each do
      @merchant = create(:merchant, :with_items)
      get "/api/v1/merchants/#{@merchant.id}/items"
    end

    it 'sends list of all items from one merchant' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items).to_not be_empty
      expect(items.count).to eq(5)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(Integer)

        expect(item).to have_key(:name)
        expect(item[:name]).to be_an(String)

        expect(item).to have_key(:description)
        expect(item[:description]).to be_an(String)

        expect(item).to have_key(:unit_price)
        expect(item[:unit_price]).to be_a(Float)

        expect(item).to have_key(:merchant_id)
        expect(item[:merchant_id]).to be_a(Integer)

        expect(item).to have_key(:created_at)
        expect(item[:created_at]).to be_an(String)

        expect(item).to have_key(:updated_at)
        expect(item[:updated_at]).to be_an(String)
      end
    end

    it 'returns error when record does not exist' do
      get "/api/v1/merchants/0/items"
      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find Merchant with \'id\'=0')
    end
  end
end
