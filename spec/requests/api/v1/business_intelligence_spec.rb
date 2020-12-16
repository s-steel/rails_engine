require 'rails_helper'

RSpec.describe 'Business Intelligence API', type: :request do
  describe 'GET /merchants/most_revenue?quantity=x' do
    before :each do
      get '/api/v1/merchants/most_revenue?quantity=2'
    end

    it 'returns merchants ranked by total revenue' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants).to_not be_empty
      merchants_data = merchants[:data]
      expect(merchants_data.count).to eq(2)
    end

    it 'returns a variable number of merchants'
  end

  # describe 'GET /merchants/most_items?quantity=x' do
  #   before :each do
  #     get '/api/v1/merchants/most_items?quantity=2'
  #   end
  # end

  # describe 'GET /revenue?start=<start_date>&end=<end_date>' do
  #   before :each do
  #     get '/api/v1/revenue?start=2012-03-09&end=2012-03-24'
  #   end
  # end

  # describe 'GET /merchants/:id/revenue' do
  #   before :each do
  #     get '/api/v1/merchants/1/revenue'
  #   end
  # end
end