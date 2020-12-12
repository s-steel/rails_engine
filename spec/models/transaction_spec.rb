require 'rails_helper'

describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
  end

  describe 'validations' do

  end
end