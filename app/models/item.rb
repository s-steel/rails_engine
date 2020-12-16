class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :description,
                        :unit_price

  def self.search_one(attribute, value)
    where("lower(#{attribute}) like ?", "%#{value.downcase}%").first
    # where("#{attribute} like ?", "%#{value}%").first
  end

  def self.search_all(attribute, value)
    where("lower(#{attribute}) like ?", "%#{value.downcase}%")
    # where("#{attribute} like ?", "%#{value}%").first
  end
end
