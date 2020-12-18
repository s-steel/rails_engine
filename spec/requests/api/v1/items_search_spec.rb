require 'rails_helper'

RSpec.describe 'Item Search API', type: :request do
  describe 'GET /items/find?<attribute>=<value>' do
    before :each do
      create_list(:item, 3)
      @solo_item = create(:item, name: 'AsDfgHjkl', description: 'What are these?', unit_price: 100_000)
    end

    it 'returns single item that matches criteria' do
      get '/api/v1/items/find?name=fghj'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      item = JSON.parse(response.body, symbolize_names: true)
      expect(item).to_not be_empty
      item_data = item[:data]
      expect(item.count).to eq(1)

      expect(item_data).to have_key(:id)
      expect(item_data[:id]).to be_a(String)

      expect(item_data).to have_key(:attributes)
      expect(item_data[:attributes]).to be_a(Hash)

      expect(item_data).to have_key(:type)
      expect(item_data[:type]).to be_a(String)

      expect(item_data[:attributes]).to have_key(:name)
      expect(item_data[:attributes][:name]).to eq(@solo_item.name)

      expect(item_data[:attributes]).to have_key(:description)
      expect(item_data[:attributes][:description]).to eq(@solo_item.description)

      expect(item_data[:attributes]).to have_key(:unit_price)
      expect(item_data[:attributes][:unit_price]).to eq(@solo_item.unit_price)

      expect(item_data[:attributes]).to have_key(:merchant_id)
      expect(item_data[:attributes][:merchant_id]).to be_a(Integer)
    end

    it 'can search using other criteria' do
      get '/api/v1/items/find?description=hese?'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      item = JSON.parse(response.body, symbolize_names: true)
      expect(item).to_not be_empty
      item_data = item[:data]
      expect(item.count).to eq(1)

      expect(item_data[:attributes][:name]).to eq(@solo_item.name)
      expect(item_data[:attributes][:description]).to eq(@solo_item.description)
      expect(item_data[:attributes][:unit_price]).to eq(@solo_item.unit_price)
      expect(item_data[:attributes][:merchant_id]).to be_a(Integer)
    end

    xit 'can find item using updated_at' do
      get '/api/v1/merchants/find?updated_at=44:45.23873'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant).to_not be_empty
      merchant_data = merchant[:data]
      expect(merchant.count).to eq(1)

      # expect(merchant_data[:attributes][:name]).to eq('Fahey-Stiedemann')
    end
  end

  describe 'GET /items/find_all?<attribute>=<value>' do
    before :each do
      @item1 = create(:item, name: 'Wooden Pants')
      @item2 = create(:item, name: 'Woodchuck Chucker')
      create(:item, name: 'Wooho Doah')
    end

    it 'finds all items that meet that criteria' do
      get '/api/v1/items/find_all?name=wood'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items).to_not be_empty
      items_data = items[:data]
      expect(items_data.count).to eq(2)
      expect(items_data[0][:attributes][:name]).to eq('Wooden Pants')
      expect(items_data[1][:attributes][:name]).to eq('Woodchuck Chucker')

      items_data.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_an(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_an(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    xit 'can find items using updated_at' do
      get '/api/v1/items/find_all?updated_at=44:45'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items).to_not be_empty
      items_data = items[:data]
      expect(items.count).to eq(1)

      # expect(merchant_data[:attributes][:name]).to eq('Fahey-Stiedemann')
    end
  end
end
