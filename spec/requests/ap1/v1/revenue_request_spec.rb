require 'rails_helper'

describe "Rail Engine API-Revenue" do

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')

    @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 10)
    @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 20)
    @item_4 = @merchant_1.items.create!(name: 'Item 4', description: 'Four Description', unit_price: 20)
    @item_5 = @merchant_1.items.create!(name: 'Item 5', description: 'Five Description', unit_price: 30)
    @item_6 = @merchant_1.items.create!(name: 'Item 6', description: 'Six Description', unit_price: 20)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer_2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @customer_3 = Customer.create!(first_name: "Jill", last_name: "Biden")
    @customer_4 = Customer.create!(first_name: "Adriana", last_name: "Green")
    @customer_5 = Customer.create!(first_name: "Sally", last_name: "May")
    @customer_6 = Customer.create!(first_name: "Jo", last_name: "Shmoe")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "completed", created_at: "1991-03-23 21:40:46")
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: "cancelled", created_at: "1992-01-28 21:40:46")
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: "completed", created_at: "1993-01-28 21:40:46")
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: "completed", created_at: "1994-01-28 21:40:46")
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: "completed", created_at: "1995-01-28 21:40:46")
    @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: "cancelled", created_at: "2021-01-28 21:40:46")
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: "completed", created_at: "2021-01-28 21:40:46")

    @invoice_items_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1)
    @invoice_items_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2)
    @invoice_items_4 = InvoiceItem.create!(item: @item_4, invoice: @invoice_4)
    @invoice_items_5 = InvoiceItem.create!(item: @item_5, invoice: @invoice_5)
    @invoice_items_6 = InvoiceItem.create!(item: @item_6, invoice: @invoice_6)
    @invoice_items_7 = InvoiceItem.create!(item: @item_1, invoice: @invoice_7)

    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000000000, credit_card_expiration_date: '2000-01-01 00:00:00 -0500', result: true)
    @transaction_02 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000001111, credit_card_expiration_date: '2001-01-01 00:00:00 -0500', result: true)
    @transaction_03 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000002222, credit_card_expiration_date: '2002-01-01 00:00:00 -0500', result: true)
    @transaction_04 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_05 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2004-01-01 00:00:00 -0500', result: false)
    @transaction_06 = Transaction.create!(invoice_id: @invoice_3.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: true)
    @transaction_08 = Transaction.create!(invoice_id: @invoice_4.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_09 = Transaction.create!(invoice_id: @invoice_5.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_10 = Transaction.create!(invoice_id: @invoice_3.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_11 = Transaction.create!(invoice_id: @invoice_3.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_12 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_13 = Transaction.create!(invoice_id: @invoice_5.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_14 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_15 = Transaction.create!(invoice_id: @invoice_5.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_16 = Transaction.create!(invoice_id: @invoice_4.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_17 = Transaction.create!(invoice_id: @invoice_6.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_18 = Transaction.create!(invoice_id: @invoice_6.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
    @transaction_19 = Transaction.create!(invoice_id: @invoice_3.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_20 = Transaction.create!(invoice_id: @invoice_4.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
    @transaction_21 = Transaction.create!(invoice_id: @invoice_5.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_22 = Transaction.create!(invoice_id: @invoice_6.id, credit_card_number: 0000000000003333, credit_card_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
  end

  describe 'Happy Paths' do
    it "can get the total revenue for a given merchant" do

      get "/api/v1/revenue/merchants/#{@merchant_1.id}"

      expect(response).to be_successful

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(revenue).to be_a(Hash)
      expect(revenue[:data]).to be_a(Array)

      expect(revenue[:data]).to have_key(:id)
      expect(revenue[:data][:id].to_i).to eq(@merchant_1.id)
      expect(revenue[:data]).to have_key(:type)
      expect(revenue[:data][:type]).to eq("merchant_revenue")
      expect(revenue[:data]).to have_key(:type)
      expect(revenue[:data][:type]).to eq("merchant_revenue")

      expect(revenue[:data]).to have_key(:attributes)
      expect(revenue[:data][:attributes]).to be_a(Hash)
      expect(revenue[:data][:attributes]).to have_key(:revenue)
      expect(revenue[:data][:attributes][:revenue]).to eq(100)
    end
  end
end
