class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true

  def self.search_one(attribute, value)
    find_by("lower(#{attribute}) like ?", "%#{value.downcase}%")
    # where("updated_at = ?", "2012-03-27 14:54:09")
  end

  def self.search_all(attribute, value)
    where("lower(#{attribute}) like ?", "%#{value.downcase}%")
  end

  def self.most_revenue(limit = 10)
    select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity)  AS revenue')
      .joins(invoices: %i[invoice_items transactions])
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .order('revenue DESC')
      .limit(limit)
  end

  def self.revenue(merchant_id)
    select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity)  AS revenue')
      .joins(invoices: %i[invoice_items transactions])
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .find_by(id: merchant_id)
  end

  def self.total_items(limit = 10)
    select('merchants.*, SUM(invoice_items.quantity) AS total_items')
      .joins(invoices: %i[invoice_items transactions])
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .order('total_items DESC')
      .limit(limit)
  end
end
