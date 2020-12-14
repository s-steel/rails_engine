require 'rails_helper'

RSpec.describe 'Item API', type: :request do
  describe 'GET /items' do
    before :each do
      create_list(:item, 5)
      get '/api/v1/items'
    end

    it 'returns list of items' do
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
  end

  describe 'GET /items/:id' do
    before :each do
      @item = create(:item)
      get "/api/v1/items/#{@item.id}"
    end

    it 'returns one item by id' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      item = JSON.parse(response.body, symbolize_names: true)
      expect(item).to_not be_empty

      expect(item).to have_key(:id)
      expect(item[:id]).to eq(@item.id)

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

    it 'returns error when there is no item with that id' do
      get '/api/v1/items/100'
      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find Item with \'id\'=100')
    end
  end

  describe 'POST /items' do
    before :each do
      @merchant = create(:merchant)
      @item_params = { name: 'Test Item',
                       description: 'Does this work??',
                       unit_price: 5.99,
                       merchant_id: @merchant.id }
    end

    it 'can create a new item' do
      post '/api/v1/items', params: @item_params
      item_info = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response).to have_http_status(201)
      expect(item_info[:name]).to eq(@item_params[:name])
      expect(item_info[:description]).to eq(@item_params[:description])
      expect(item_info[:unit_price]).to eq(@item_params[:unit_price])
      expect(item_info[:merchant_id]).to eq(@item_params[:merchant_id])
    end

    it 'will error out if request is invalid' do
      invalid_params = { name: '' }
      post '/api/v1/merchants', params: invalid_params
      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      expect(response.body).to match('Validation failed: Name can\'t be blank')

      # invalid_params = { name: 'Test Item',
      #                    unit_price: 5.99,
      #                    merchant_id: @merchant.id }
      # post '/api/v1/merchants', params: invalid_params
      # expect(response).to_not be_successful
      # expect(response).to have_http_status(422)
      # expect(response.body).to match('Validation failed: Description can\'t be blank')

    end
  end
end
