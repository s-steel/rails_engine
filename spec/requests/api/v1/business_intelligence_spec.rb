require 'rails_helper'

RSpec.describe 'Business Intelligence API', type: :request do
  describe 'GET /merchants/most_revenue?quantity=x' do
    before :each do
      @merch1 = create(:merchant)
      invoice1 = create(:invoice, merchant_id: @merch1.id)
      item1 = create(:item)
      invoice1.invoice_items.create(item_id: item1.id, quantity: 40, unit_price: 100)
      invoice1.transactions.create(credit_card_number: 1234567823456789, credit_card_expiration_date: '04/23', result: 'success')

      @merch2 = create(:merchant)
      invoice2 = create(:invoice, merchant_id: @merch2.id)
      item2 = create(:item)
      invoice2.invoice_items.create(item_id: item2.id, quantity: 20, unit_price: 100)
      invoice2.transactions.create(credit_card_number: 1234567823456789, credit_card_expiration_date: '04/23', result: 'success')

      @merch3 = create(:merchant)
      invoice3 = create(:invoice, merchant_id: @merch3.id)
      item3 = create(:item)
      invoice3.invoice_items.create(item_id: item3.id, quantity: 10, unit_price: 100)
      invoice3.transactions.create(credit_card_number: 1234567823456789, credit_card_expiration_date: '04/23', result: 'success')

      # @merch2 = create(:merchant)
      # @merch3 = create(:merchant)
      # @merch4 = create(:merchant)
      # invoice2 = create(:invoice, merchant_id: @merch1.id)
      # invoice3 = create(:invoice, merchant_id: @merch2.id)
      # invoice4 = create(:invoice, merchant_id: @merch3.id)
      # invoice5 = create(:invoice, merchant_id: @merch4.id)
      # invoice6 = create(:invoice, merchant_id: @merch4.id)
      # invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 10, unit_price: 10.50)
      # invoice_item2 = create(:invoice_item, invoice_id: invoice1.id, quantity: 5, unit_price: 6.32)
      # invoice_item3 = create(:invoice_item, invoice_id: invoice2.id, quantity: 15, unit_price: 9.65)
      # invoice_item4 = create(:invoice_item, invoice_id: invoice3.id, quantity: 21, unit_price: 11.20)
      # invoice_item5 = create(:invoice_item, invoice_id: invoice4.id, quantity: 25, unit_price: 3.20)
      # invoice_item6 = create(:invoice_item, invoice_id: invoice4.id, quantity: 7, unit_price: 15.21)
      # invoice_item7 = create(:invoice_item, invoice_id: invoice5.id, quantity: 18, unit_price: 10.98)
      # invoice_item8 = create(:invoice_item, invoice_id: invoice4.id, quantity: 31, unit_price: 2.76)
      # invoice_item8 = create(:invoice_item, invoice_id: invoice6.id, quantity: 5, unit_price: 100.34)
      # @merch4.invoices << [invoice6]
      # @merch1.invoices << [invoice2, invoice5]
      # @merch2.invoices << [invoice3]
      # @merch3.invoices << [invoice1, invoice4]
    end

    it 'returns merchants ranked by total revenue' do
      get '/api/v1/merchants/most_revenue?quantity=2'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants).to_not be_empty
      merchants_data = merchants[:data]
      expect(merchants_data.count).to eq(2)

      expect(merchants_data[0][:id]).to eq(@merch1.id.to_s)
      expect(merchants_data[1][:id]).to eq(@merch2.id.to_s)

      merchants_data.each do |merchant|
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

    it 'returns a variable number of merchants' do
      get '/api/v1/merchants/most_revenue?quantity=1'
      merchants = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(merchants.count).to eq(1)

      get '/api/v1/merchants/most_revenue?quantity=3'
      merchants = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(merchants.count).to eq(3)
    end
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
      @merch1 = create(:merchant)
      invoice1 = create(:invoice, merchant_id: @merch1.id)
      item1 = create(:item)
      invoice1.invoice_items.create(item_id: item1.id, quantity: 40, unit_price: 100)
      invoice1.transactions.create(credit_card_number: 1234567823456789, credit_card_expiration_date: '04/23', result: 'success')

      @merch2 = create(:merchant)
      invoice2 = create(:invoice, merchant_id: @merch2.id)
      item2 = create(:item)
      invoice2.invoice_items.create(item_id: item2.id, quantity: 20, unit_price: 100)
      invoice2.transactions.create(credit_card_number: 1234567823456789, credit_card_expiration_date: '04/23', result: 'success')

      @merch3 = create(:merchant)
      invoice3 = create(:invoice, merchant_id: @merch3.id)
      item3 = create(:item)
      invoice3.invoice_items.create(item_id: item3.id, quantity: 10, unit_price: 100)
      invoice3.transactions.create(credit_card_number: 1234567823456789, credit_card_expiration_date: '04/23', result: 'success')
    end

    it 'returns revenue for an individual merchant' do
      get "/api/v1/merchants/#{@merch1.id}/revenue"
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant).to_not be_empty
      merchant_data = merchant[:data]
      expect(merchant.count).to eq(1)

      expect(merchant_data).to have_key(:id)
      expect(merchant_data[:id]).to be_nil

      expect(merchant_data).to have_key(:attributes)
      expect(merchant_data[:attributes]).to be_a(Hash)

      expect(merchant_data[:attributes]).to have_key(:revenue)
      expect(merchant_data[:attributes][:revenue]).to be_a(Float)

      expect(merchant_data[:attributes][:revenue]).to eq(40 * 100)
    end
  end
end