class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions, dependent: :destroy

  validates :status, presence: true

  scope :shipped, -> { where(status: 'shipped') }

  def self.revenue_by_dates(start_date, end_date)
    end_of_day = "#{end_date} 23:59:59"
    revenue = joins(:invoice_items, :transactions)
              .where('invoices.created_at >= ? AND invoices.created_at <= ?', start_date, end_of_day)
              .select('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
              .merge(Transaction.successful)
              .merge(Invoice.shipped)
    revenue[0]
  end
end
