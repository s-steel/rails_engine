require 'rails_helper'

RSpec.describe 'Business Intelligence API', type: :request do
  describe 'GET /merchants/most_revenue?quantity=x' do
    before :each do
      @merch1 = create(:merchant)
      invoice1 = create(:invoice, merchant_id: @merch1.id)
      item1 = create(:item)
      invoice1.invoice_items.create(item_id: item1.id,
                                    quantity: 40,
                                    unit_price: 100)
      invoice1.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')

      @merch2 = create(:merchant)
      invoice2 = create(:invoice, merchant_id: @merch2.id)
      item2 = create(:item)
      invoice2.invoice_items.create(item_id: item2.id,
                                    quantity: 20,
                                    unit_price: 100)
      invoice2.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')

      @merch3 = create(:merchant)
      invoice3 = create(:invoice, merchant_id: @merch3.id)
      item3 = create(:item)
      invoice3.invoice_items.create(item_id: item3.id,
                                    quantity: 10,
                                    unit_price: 100)
      invoice3.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')
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

  describe 'GET /merchants/most_items?quantity=x' do
    before :each do
      # @merch1 = create(:merchant, :with_items)
      # @merch2 = create(:merchant, :with_items)
      # @merch3 = create(:merchant, :with_items)
      # item1 = @merch1.items[0]
      # item2 = @merch2.items[0]
      # item3 = @merch3.items[0]
      # create(:invoice_item, item_id: item1.id, quantity: 20)
      # create(:invoice_item, item_id: item1.id, quantity: 10)
      # create(:invoice_item, item_id: item2.id, quantity: 50)
      # create(:invoice_item, item_id: item2.id, quantity: 5)
      # create(:invoice_item, item_id: item3.id, quantity: 10)
      # create(:invoice_item, item_id: item3.id, quantity: 32)

      @merch1 = create(:merchant)
      invoice1 = create(:invoice, merchant_id: @merch1.id)
      item1 = create(:item)
      invoice1.invoice_items.create(item_id: item1.id,
                                    quantity: 20,
                                    unit_price: 100)
      invoice1.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')

      @merch2 = create(:merchant)
      invoice2 = create(:invoice, merchant_id: @merch2.id)
      item2 = create(:item)
      invoice2.invoice_items.create(item_id: item2.id,
                                    quantity: 50,
                                    unit_price: 100)
      invoice2.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')

      @merch3 = create(:merchant)
      invoice3 = create(:invoice, merchant_id: @merch3.id)
      item3 = create(:item)
      invoice3.invoice_items.create(item_id: item3.id,
                                    quantity: 32,
                                    unit_price: 100)
      invoice3.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')
    end

    it 'returns merchants based on total items' do
      get '/api/v1/merchants/most_items?quantity=2'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants).to_not be_empty
      merchants_data = merchants[:data]

      expect(merchants_data.count).to eq(2)
      expect(merchants_data[0][:id]).to eq(@merch2.id.to_s)
      expect(merchants_data[1][:id]).to eq(@merch3.id.to_s)

      one_merchant = merchants_data.first
      expect(one_merchant).to have_key(:id)
      expect(one_merchant[:id]).to be_a(String)

      expect(one_merchant).to have_key(:type)
      expect(one_merchant[:type]).to be_a(String)

      expect(one_merchant).to have_key(:attributes)
      expect(one_merchant[:attributes]).to be_a(Hash)

      expect(one_merchant[:attributes]).to have_key(:name)
      expect(one_merchant[:attributes][:name]).to be_a(String)
    end
  end

  describe 'GET /revenue?start=<start_date>&end=<end_date>' do
    before :each do
      @merch1 = create(:merchant)
      invoice1 = create(:invoice,
                        merchant_id: @merch1.id,
                        created_at: '2012-08-27 14:54:09')
      item1 = create(:item)
      invoice1.invoice_items.create(item_id: item1.id,
                                    quantity: 40,
                                    unit_price: 100)
      invoice1.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')

      @merch2 = create(:merchant)
      invoice2 = create(:invoice,
                        merchant_id: @merch2.id,
                        created_at: '2012-04-07 14:54:09')
      item2 = create(:item)
      invoice2.invoice_items.create(item_id: item2.id,
                                    quantity: 20,
                                    unit_price: 100)
      invoice2.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')

      @merch3 = create(:merchant)
      invoice3 = create(:invoice,
                        merchant_id: @merch3.id,
                        created_at: '2012-03-29 14:54:09')
      item3 = create(:item)
      invoice3.invoice_items.create(item_id: item3.id,
                                    quantity: 10,
                                    unit_price: 100)
      invoice3.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')
    end

    it 'returns total revenue across all merchants between given dates' do
      get '/api/v1/revenue?start=2012-01-09&end=2012-07-13'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      revenue = JSON.parse(response.body, symbolize_names: true)
      expect(revenue).to_not be_empty
      revenue_data = revenue[:data]

      expect(revenue_data).to have_key(:id)
      expect(revenue_data[:id]).to be_nil

      expect(revenue_data).to have_key(:attributes)
      expect(revenue_data[:attributes]).to be_a(Hash)

      expect(revenue_data[:attributes]).to have_key(:revenue)
      expect(revenue_data[:attributes][:revenue]).to be_a(Float)

      expect(revenue_data[:attributes][:revenue]).to eq(3_000)
    end
  end

  describe 'GET /merchants/:id/revenue' do
    before :each do
      @merch1 = create(:merchant)
      invoice1 = create(:invoice, merchant_id: @merch1.id)
      item1 = create(:item)
      invoice1.invoice_items.create(item_id: item1.id,
                                    quantity: 40,
                                    unit_price: 100)
      invoice1.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')

      @merch2 = create(:merchant)
      invoice2 = create(:invoice, merchant_id: @merch2.id)
      item2 = create(:item)
      invoice2.invoice_items.create(item_id: item2.id,
                                    quantity: 20,
                                    unit_price: 100)
      invoice2.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')
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
