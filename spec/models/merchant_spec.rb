require 'rails_helper'

describe Merchant do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')

    @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 12)
    @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 9)
    @item_3 = @merchant_1.items.create!(name: 'Item 3', description: 'Threee Description', unit_price: 7.50)

    @customer_1 = Customer.create!(first_name: "Job", last_name: "Gu")
    @customer_2 = Customer.create!(first_name: "Steve", last_name: "Smith")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "shipped", created_at: "1991-03-23 21:40:46")
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: "shipped", created_at: "1992-01-28 21:40:46")
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: "shipped", created_at: "1992-01-28 21:40:46")

    @invoice_items_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, unit_price: 12, quantity: 2)
    @invoice_items_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, unit_price: 9, quantity: 4)
    @invoice_items_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, unit_price: 7.50, quantity: 3)

    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000000000, credit_card_expiration_date: '2000-01-01 00:00:00 -0500', result: "success")
    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000000000, credit_card_expiration_date: '2000-01-01 00:00:00 -0500', result: "failed")
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "failed")
    @transaction_08= Transaction.create!(invoice_id: @invoice_3.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
  end

  describe 'relationships' do
    it {should have_many(:items)}
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "class methods" do
    it "total_revenue" do
      expect(Merchant.total_revenue(@merchant_1.id)[:merchant_revenue]).to eq(82.50)
    end
  end
end
