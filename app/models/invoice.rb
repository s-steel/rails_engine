class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions, dependent: :destroy

  validates_presence_of :status
end
