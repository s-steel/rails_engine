require 'rails_helper'

describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'validations' do

  end
end