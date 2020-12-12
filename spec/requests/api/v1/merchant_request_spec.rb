require 'rails_helper'

RSpec.describe 'Merchant API', type: :request do
  describe 'GET /merchants' do
    before :each do
      create_list(:merchant, 3)
      get '/api/v1/merchants'
    end

    it 'sends a list of merchants' do
      expect(response).to be_successful
      merchants = JSON.parse(response.body)
    end
  end
end

# let!(:shelter1) { create(:shelter, name: 'Test Shelter 1') }