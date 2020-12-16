require 'rails_helper'

describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    before :each do
      @merch1 = create(:merchant)
      invoice1 = create(:invoice, merchant_id: @merch1.id)
      item1 = create(:item)
      invoice1.invoice_items.create(item_id: item1.id,
                                    quantity: 40,
                                    unit_price: 100)
      invoice1.transactions.create(credit_card_number: 1234567823456789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')

      @merch2 = create(:merchant)
      invoice2 = create(:invoice, merchant_id: @merch2.id)
      item2 = create(:item)
      invoice2.invoice_items.create(item_id: item2.id,
                                    quantity: 10,
                                    unit_price: 100)
      invoice2.transactions.create(credit_card_number: 1234567823456789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')

      @merch3 = create(:merchant)
      invoice3 = create(:invoice, merchant_id: @merch3.id)
      item3 = create(:item)
      invoice3.invoice_items.create(item_id: item3.id,
                                    quantity: 20,
                                    unit_price: 100)
      invoice3.transactions.create(credit_card_number: 1234567823456789,
                                   credit_card_expiration_date: '04/23',
                                   result: 'success')
    end

    it '.most_revenue' do
      results = Merchant.most_revenue(2)
      expect(results.length).to eq(2)
      expect(results[0].id).to eq(@merch1.id)
      expect(results[1].id).to eq(@merch3.id)
    end

    it '.revenue' do
      results = Merchant.revenue(@merch2.id)
      expect(results.id).to eq(@merch2.id)
    end

    it '.search_one' do
      merch1 = create(:merchant, name: 'Other School')
      merch2 = create(:merchant, name: 'Party House')
      merch3 = create(:merchant, name: 'Ring World')

      results = Merchant.search_one('name', 'ring')
      expect(results.id).to eq(merch3.id)
    end

    it '.search_all' do
      merch1 = create(:merchant, name: 'Turing School')
      merch2 = create(:merchant, name: 'Party House')
      merch3 = create(:merchant, name: 'Ring World')

      results = Merchant.search_all('name', 'ring')
      expect(results.length).to eq(2)
      expect(results[0].id).to eq(merch1.id)
      expect(results[1].id).to eq(merch3.id)
    end
  end
end
