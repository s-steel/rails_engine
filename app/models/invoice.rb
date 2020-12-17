class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions, dependent: :destroy

  validates_presence_of :status

  scope :shipped, -> { where(status: 'shipped') }

  def self.revenue_by_dates(start_date, end_date)
    require 'pry', binding.pry
  end
end
