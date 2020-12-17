require 'rails_helper'

describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'class methods' do
    it '.search_one' do
      create(:item, name: 'Piece of Paper')
      item2 = create(:item, name: 'Woodchuck Chucker')
      item3 = create(:item, name: 'Wooho Doah', description: 'What are these?')

      results1 = Item.search_one('name', 'wood')
      expect(results1.name).to eq(item2.name)

      results2 = Item.search_one('description', 'hese?')
      expect(results2.name).to eq(item3.name)
    end

    it '.search_all' do
      item1 = create(:item, name: 'Wooden Pants')
      item2 = create(:item, name: 'Woodchuck Chucker')
      create(:item, name: 'Wooho Doah', description: 'What are these?')

      results = Item.search_all('name', 'wood')
      expect(results.length).to eq(2)
      expect(results[0].id).to eq(item1.id)
      expect(results[1].id).to eq(item2.id)
    end
  end
end
