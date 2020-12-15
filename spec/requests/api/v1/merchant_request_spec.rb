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
      merchant_data = merchants[:data]
      expect(merchant_data.count).to eq(3)

      merchant_data.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_an(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_an(String)
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
      merchant_data = merchant[:data]

      expect(merchant_data).to have_key(:id)
      expect(merchant_data[:id]).to eq("#{@merch1.id}")

      expect(merchant_data).to have_key(:attributes)
      expect(merchant_data[:attributes]).to be_a(Hash)

      expect(merchant_data[:attributes]).to have_key(:name)
      expect(merchant_data[:attributes][:name]).to be_an(String)

      expect(merchant_data).to have_key(:type)
      expect(merchant_data[:type]).to be_an(String)
    end

    it 'returns error when there is no merchant with that id' do
      get '/api/v1/merchants/0'
      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find Merchant with \'id\'=0')
    end
  end

  describe 'POST /merchants' do
    before :each do
      @merch_params = { name: 'Test Merchant' }
    end

    it 'can create a new merchant' do
      post '/api/v1/merchants', params: @merch_params
      merchant_info = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response).to have_http_status(201)
      expect(merchant_info[:data][:attributes][:name]).to eq(@merch_params[:name])
    end

    it 'will error out if request is invalid' do
      invalid_params = { name: '' }
      post '/api/v1/merchants', params: invalid_params
      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      expect(response.body).to match('Validation failed: Name can\'t be blank')
    end
  end

  describe 'PATCH /merchants/:id' do
    before :each do
      @merch1 = create(:merchant)
    end

    it 'can update an existing merchant' do
      old_name = @merch1.name
      new_name = { name: 'New Name' }
      patch "/api/v1/merchants/#{@merch1.id}", params: new_name
      new_merchant_info = Merchant.find_by(id: @merch1.id)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(new_merchant_info.name).to eq(new_name[:name])
      expect(new_merchant_info.name).to_not eq(old_name)
    end

    it 'returns error if record doesn\'t exist' do
      params = { name: 'New Name' }
      patch '/api/v1/merchants/0', params: params
      expect(response).to_not be_successful
      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find Merchant with \'id\'=0')
    end

    xit 'returns error when params are invalid' do
      invalid_params = {}
      patch "/api/v1/merchants/#{@merch1.id}", params: invalid_params
      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      expect(response.body).to match('Validation failed: Name can\'t be blank')
    end
  end

  describe 'DELETE /merchants' do
    before :each do
      create_list(:merchant, 3)
      @merch1 = Merchant.first
      @merch2 = Merchant.last
    end

    it 'can detroy a merchant' do
      expect(Merchant.count).to eq(3)
      delete "/api/v1/merchants/#{@merch1.id}"

      expect(response).to be_successful
      expect(response).to have_http_status(204)
      expect(Merchant.count).to eq(2)
      expect { Merchant.find(@merch1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect { delete "/api/v1/merchants/#{@merch2.id}" }.to change(Merchant, :count).by(-1)
    end

    xit 'returns error if record doesn\'t exist' do
      delete '/api/v1/merchants/0'
      expect(response).to_not be_successful
      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find Merchant with \'id\'=0')
    end
  end
end
