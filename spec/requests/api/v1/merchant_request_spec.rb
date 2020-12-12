require 'rails_helper'

RSpec.describe 'Merchant API', type: :request do
  describe 'GET /merchants' do
    before :each do
      create_list(:merchant, 3)
      get '/api/v1/merchants'
    end

    it 'sends a list of merchants' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants).to_not be_empty
      expect(merchants.count).to eq(3)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(Integer)

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_an(String)

        expect(merchant).to have_key(:created_at)
        expect(merchant[:created_at]).to be_an(String)

        expect(merchant).to have_key(:updated_at)
        expect(merchant[:updated_at]).to be_an(String)
      end
    end
  end

  describe 'GET /merchants/:id' do
    before :each do
      @merch1 = create(:merchant)
      get "/api/v1/merchants/#{@merch1.id}"
    end

    it 'returns one merchant by id' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant).to_not be_empty

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to eq(@merch1.id)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_an(String)

      expect(merchant).to have_key(:created_at)
      expect(merchant[:created_at]).to be_an(String)

      expect(merchant).to have_key(:updated_at)
      expect(merchant[:updated_at]).to be_an(String)
    end

    # it 'when record doesn\'t exist' do
    #   get "/api/v1/merchants/100}"
    #   expect(response).to have_http_status(404)
    #   expect(response.body).to match(/Couldn't find Todo/)
    # end
  end
end

# let!(:shelter1) { create(:shelter, name: 'Test Shelter 1') }
