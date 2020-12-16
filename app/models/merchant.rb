class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def self.search_one(attribute, value)
    where("lower(#{attribute}) like ?", "%#{value.downcase}%").first
    # where("#{attribute} like ?", "%#{value}%").first
  end
end
