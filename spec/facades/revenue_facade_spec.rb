require 'rails_helper'

RSpec.describe RevenueFacade do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')
    @merchant_2 = Merchant.create!(name: 'glamzaon')
    @merchant_3 = Merchant.create!(name: 'shamazon')
    @merchant_4 = Merchant.create!(name: 'bad store')
    @merchant_5 = Merchant.create!(name: 'really bad store')
    @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 12)
    @item_2 = @merchant_2.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 9)
    @item_3 = @merchant_3.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 9)
    @item_4 = @merchant_4.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 9)
    @item_5 = @merchant_5.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 9)
    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer_2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "shipped", created_at: "1991-03-23 21:40:46")
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: "shipped", created_at: "1992-01-28 21:40:46")
    @invoice_3 = Invoice.create!(customer_id: @customer_1.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_4 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_5 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_6 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_7 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_8 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_9 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_10 = Invoice.create!(customer_id: @customer_2.id, status: "shipped", created_at: "1992-01-28 21:40:46")
    @invoice_11 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_12 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_13 = Invoice.create!(customer_id: @customer_2.id, status: "shipped", created_at: "1992-01-28 21:40:46")
    @invoice_14 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_15 = Invoice.create!(customer_id: @customer_2.id, status: "packaged", created_at: "1992-01-28 21:40:46")
    @invoice_items_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, unit_price: 12, quantity: 2)
    @invoice_items_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, unit_price: 9, quantity: 4)
    @invoice_items_3 = InvoiceItem.create!(item: @item_2, invoice: @invoice_3, unit_price: 9, quantity: 2)
    @invoice_items_4 = InvoiceItem.create!(item: @item_2, invoice: @invoice_4, unit_price: 9, quantity: 3)
    @invoice_items_5 = InvoiceItem.create!(item: @item_2, invoice: @invoice_5, unit_price: 9, quantity: 4)
    @invoice_items_6 = InvoiceItem.create!(item: @item_2, invoice: @invoice_6, unit_price: 9, quantity: 1)
    @invoice_items_7 = InvoiceItem.create!(item: @item_4, invoice: @invoice_7, unit_price: 9, quantity: 2)
    @invoice_items_8 = InvoiceItem.create!(item: @item_2, invoice: @invoice_8, unit_price: 9, quantity: 3)
    @invoice_items_9 = InvoiceItem.create!(item: @item_2, invoice: @invoice_9, unit_price: 9, quantity: 4)
    @invoice_items_10 = InvoiceItem.create!(item: @item_3, invoice: @invoice_10, unit_price: 9, quantity: 5)
    @invoice_items_11 = InvoiceItem.create!(item: @item_2, invoice: @invoice_11, unit_price: 9, quantity: 6)
    @invoice_items_12 = InvoiceItem.create!(item: @item_2, invoice: @invoice_12, unit_price: 9, quantity: 7)
    @invoice_items_13 = InvoiceItem.create!(item: @item_5, invoice: @invoice_13, unit_price: 9, quantity: 8)
    @invoice_items_14 = InvoiceItem.create!(item: @item_2, invoice: @invoice_14, unit_price: 9, quantity: 9)
    @invoice_items_15 = InvoiceItem.create!(item: @item_2, invoice: @invoice_15, unit_price: 9, quantity: 10)
    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000000000, credit_card_expiration_date: '2000-01-01 00:00:00 -0500', result: "success")
    @transaction_02 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000000000, credit_card_expiration_date: '2000-01-01 00:00:00 -0500', result: "failed")
    @transaction_03 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_04 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "failed")
    @transaction_05 = Transaction.create!(invoice_id: @invoice_3.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_06 = Transaction.create!(invoice_id: @invoice_4.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_07 = Transaction.create!(invoice_id: @invoice_5.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_08 = Transaction.create!(invoice_id: @invoice_6.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_09 = Transaction.create!(invoice_id: @invoice_7.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_10 = Transaction.create!(invoice_id: @invoice_8.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_11 = Transaction.create!(invoice_id: @invoice_9.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_12 = Transaction.create!(invoice_id: @invoice_10.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_13 = Transaction.create!(invoice_id: @invoice_11.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_14 = Transaction.create!(invoice_id: @invoice_12.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_15 = Transaction.create!(invoice_id: @invoice_13.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_16 = Transaction.create!(invoice_id: @invoice_14.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_17 = Transaction.create!(invoice_id: @invoice_15.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "failed")
    @transaction_18 = Transaction.create!(invoice_id: @invoice_15.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
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

    it "sanatize_active_record_data returns UnshippedOrder poros" do
      expect(RevenueFacade.sanatize_active_record_data(4).count).to eq(4)
      expect(RevenueFacade.sanatize_active_record_data(4).last).to be_a(Array)
      expect(RevenueFacade.sanatize_active_record_data(4).last[0]).to eq(@merchant_1.id)
      expect(RevenueFacade.sanatize_active_record_data(4).last[1]).to eq(24.0)

    end
    it "top_merchants_poro_data returns UnshippedOrder poros" do
      expect(RevenueFacade.top_merchants_poro_data(4).count).to eq(4)
      expect(RevenueFacade.top_merchants_poro_data(4).first).to be_a(Array)
    end
    it "top_merchants_revenue returns TopRevenue poros" do
      expect(RevenueFacade.top_merchants_revenue(4).count).to eq(4)
      expect(RevenueFacade.top_merchants_revenue(4).first).to be_a(TopRevenue)
    end
  end
end
