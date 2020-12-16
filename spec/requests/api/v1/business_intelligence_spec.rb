require 'rails_helper'

RSpec.describe 'Business Intelligence API', type: :request do
  describe 'GET /merchants/most_revenue?quantity=x' do
    before :each do
      @merch1 = create(:merchant)
      @merch2 = create(:merchant)
      @merch3 = create(:merchant)
      @merch4 = create(:merchant)
      invoice1 = create(:invoice, merchant_id: @merch1.id)
      invoice2 = create(:invoice, merchant_id: @merch1.id)
      invoice3 = create(:invoice, merchant_id: @merch2.id)
      invoice4 = create(:invoice, merchant_id: @merch3.id)
      invoice5 = create(:invoice, merchant_id: @merch4.id)
      invoice6 = create(:invoice, merchant_id: @merch4.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 10, unit_price: 10.50)
      invoice_item2 = create(:invoice_item, invoice_id: invoice1.id, quantity: 5, unit_price: 6.32)
      invoice_item3 = create(:invoice_item, invoice_id: invoice2.id, quantity: 15, unit_price: 9.65)
      invoice_item4 = create(:invoice_item, invoice_id: invoice3.id, quantity: 21, unit_price: 11.20)
      invoice_item5 = create(:invoice_item, invoice_id: invoice4.id, quantity: 25, unit_price: 3.20)
      invoice_item6 = create(:invoice_item, invoice_id: invoice4.id, quantity: 7, unit_price: 15.21)
      invoice_item7 = create(:invoice_item, invoice_id: invoice5.id, quantity: 18, unit_price: 10.98)
      invoice_item8 = create(:invoice_item, invoice_id: invoice4.id, quantity: 31, unit_price: 2.76)
      invoice_item8 = create(:invoice_item, invoice_id: invoice6.id, quantity: 5, unit_price: 100.34)
      @merch4.invoices << [invoice6]
      @merch1.invoices << [invoice2, invoice5]
      @merch2.invoices << [invoice3]
      @merch3.invoices << [invoice1, invoice4]
    end

    it 'returns merchants ranked by total revenue' do
      get '/api/v1/merchants/most_revenue?quantity=2'
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

  describe 'GET /merchants/:id/revenue' do
    before :each do
      get '/api/v1/merchants/1/revenue'
    end

    it 'returns revenue for an individual merchant' do
      get '/api/v1/merchants/1/revenue'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants).to_not be_empty
      merchants_data = merchants[:data]
      expect(merchants_data.count).to eq(1)
    end
  end
end