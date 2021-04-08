require 'rails_helper'

RSpec.describe RevenueFacade do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')

    @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 12)
    @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 9)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer_2 = Customer.create!(first_name: "Steve", last_name: "Smith")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "shipped", created_at: "1991-03-23 21:40:46")
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: "shipped", created_at: "1992-01-28 21:40:46")
    @invoice_3 = Invoice.create!(customer_id: @customer_1.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_4 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_5 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, unit_price: 12, quantity: 2)
    @invoice_items_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, unit_price: 9, quantity: 4)
    @invoice_items_3 = InvoiceItem.create!(item: @item_2, invoice: @invoice_3, unit_price: 9, quantity: 2)
    @invoice_items_4 = InvoiceItem.create!(item: @item_2, invoice: @invoice_4, unit_price: 9, quantity: 3)
    @invoice_items_5 = InvoiceItem.create!(item: @item_2, invoice: @invoice_5, unit_price: 9, quantity: 4)
    @invoice_6 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_6 = InvoiceItem.create!(item: @item_2, invoice: @invoice_6, unit_price: 9, quantity: 1)
    @invoice_7 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_7 = InvoiceItem.create!(item: @item_2, invoice: @invoice_7, unit_price: 9, quantity: 2)
    @invoice_8 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_8 = InvoiceItem.create!(item: @item_2, invoice: @invoice_8, unit_price: 9, quantity: 3)
    @invoice_9 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_9 = InvoiceItem.create!(item: @item_2, invoice: @invoice_9, unit_price: 9, quantity: 4)
    @invoice_10 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_10 = InvoiceItem.create!(item: @item_2, invoice: @invoice_10, unit_price: 9, quantity: 5)
    @invoice_11 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_11 = InvoiceItem.create!(item: @item_2, invoice: @invoice_11, unit_price: 9, quantity: 6)
    @invoice_12 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_12 = InvoiceItem.create!(item: @item_2, invoice: @invoice_12, unit_price: 9, quantity: 7)
    @invoice_13 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_13 = InvoiceItem.create!(item: @item_2, invoice: @invoice_13, unit_price: 9, quantity: 8)
    @invoice_14 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_14 = InvoiceItem.create!(item: @item_2, invoice: @invoice_14, unit_price: 9, quantity: 9)
    @invoice_15 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_15 = InvoiceItem.create!(item: @item_2, invoice: @invoice_15, unit_price: 9, quantity: 10)

    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000000000, credit_card_expiration_date: '2000-01-01 00:00:00 -0500', result: "success")
    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000000000, credit_card_expiration_date: '2000-01-01 00:00:00 -0500', result: "failed")
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "failed")
  end

  describe 'happy path' do
    it "potential_revenue_list and gets list of invoices with non shipped items" do
      expect(RevenueFacade.potential_revenue_list(5).first).to be_a(Invoice)
    end

    it "data_about_invoices process data for poros " do
      expect(RevenueFacade.data_about_invoices(5).class).to be(Hash)
    end

    it "unshipped_invoices returns UnshippedOrder poros" do
      expect(RevenueFacade.unshipped_invoices(5).count).to eq(5)
      expect(RevenueFacade.unshipped_invoices(5).first).to be_a(UnshippedOrder)
    end
  end
end
