class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def self.search_one(attribute, value)
    # require 'pry', binding.pry
    where("lower(#{attribute}) like ?", "%#{value.downcase}%").first
    # where("#{attribute} like ?", "%#{value}%").first
  end

  def self.search_all(attribute, value)
    where("lower(#{attribute}) like ?", "%#{value.downcase}%")
    # where("#{attribute} like ?", "%#{value}%")
  end

  def self.most_revenue(limit = 10)
    select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity)  AS revenue')
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .order('revenue DESC')
      .limit(limit)
  end

  def self.revenue(merchant_id)
    select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity)  AS revenue')
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .where(id: merchant_id)
      .first
  end

  def self.total_items(limit = 10)
    select('merchants.*, SUM(invoice_items.quantity) AS total_items')
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .order('total_items DESC')
      .limit(limit)
  end
end
