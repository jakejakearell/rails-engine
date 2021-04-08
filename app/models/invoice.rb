class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.potential_revenue(quantity)
    mine = Invoice.where("invoices.status = ?", "packaged")
    .joins(:invoice_items)
    .select("(invoice_items.unit_price * invoice_items.quantity) as order_price, invoices.id")
    .order(order_price: :desc)
    .limit(quantity)
  end

  def merchant_untapped
    self.invoice_items.sum("(invoice_items.quantity * invoice_items.unit_price)")
  end
end
