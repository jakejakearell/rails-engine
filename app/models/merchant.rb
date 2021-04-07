class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.total_revenue(merchant_id)
    revenue = Merchant.find(merchant_id)
    .transactions
    .select("transactions.result, invoices.status, invoice_items.quantity, invoice_items.unit_price")
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .sum("(invoice_items.quantity * invoice_items.unit_price)")
    return {:id => merchant_id, :merchant_revenue => revenue}
  end
end
