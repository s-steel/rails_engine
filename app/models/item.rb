class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name,
            :description,
            :unit_price, presence: true

  def self.search_one(attribute, value)
    find_by("lower(#{attribute}) like ?", "%#{value.downcase}%")
  end

  def self.search_all(attribute, value)
    where("lower(#{attribute}) like ?", "%#{value.downcase}%")
  end
end
