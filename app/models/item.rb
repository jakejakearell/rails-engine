class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                      :description,
                      :unit_price,
                      :merchant_id

  def self.find_one_by_name(query)
    Item.where("name ILIKE '%#{query}%'")
    .order(:name)
    .limit(1)
  end

  def self.find_one_by_min_price(min)
    Item.where("unit_price >= ?", "#{min}")
    .order(:name)
    .limit(1)
  end

  def self.find_one_by_max_price(max)
    Item.where("unit_price <= ?", "#{max}")
    .order(:name)
    .limit(1)
  end

  def self.find_one_by_price_range(min, max)
    Item.where("unit_price >= ?","#{min}")
    .where("unit_price <= ?","#{max}")
    .order(:name)
    .limit(1)
  end
end
