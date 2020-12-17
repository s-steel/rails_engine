require 'rails_helper'

describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'class methods' do
    before :each do
      merch1 = create(:merchant)
      @invoice1 = create(:invoice,
                         merchant_id: merch1.id,
                         created_at: '2012-08-27 14:54:09')
      item1 = create(:item)
      @invoice1.invoice_items.create(item_id: item1.id,
                                     quantity: 40,
                                     unit_price: 100)
      @invoice1.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                    credit_card_expiration_date: '04/23',
                                    result: 'success')

      merch2 = create(:merchant)
      @invoice2 = create(:invoice,
                         merchant_id: merch2.id,
                         created_at: '2012-04-27 14:54:09')
      item2 = create(:item)
      @invoice2.invoice_items.create(item_id: item2.id,
                                     quantity: 10,
                                     unit_price: 100)
      @invoice2.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                    credit_card_expiration_date: '04/23',
                                    result: 'success')

      merch3 = create(:merchant)
      @invoice3 = create(:invoice,
                         merchant_id: merch3.id,
                         created_at: '2012-03-11 14:54:09')
      item3 = create(:item)
      @invoice3.invoice_items.create(item_id: item3.id,
                                     quantity: 20,
                                     unit_price: 100)
      @invoice3.transactions.create(credit_card_number: 1_234_567_823_456_789,
                                    credit_card_expiration_date: '04/23',
                                    result: 'success')
    end

    it '.revenue_by_dates' do
      results = Invoice.revenue_by_dates('2012-01-05', '2012-07-29')
      expect(results).to eq(3_000)
    end
  end
end
