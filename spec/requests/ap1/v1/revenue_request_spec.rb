require 'rails_helper'

describe "Rail Engine API-Revenue" do

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')

    @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 12)
    @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 9)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer_2 = Customer.create!(first_name: "Steve", last_name: "Smith")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "shipped", created_at: "1991-03-23 21:40:46")
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: "shipped", created_at: "1992-01-28 21:40:46")

    @invoice_items_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, unit_price: 12, quantity: 2)
    @invoice_items_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, unit_price: 9, quantity: 4)

    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000000000, credit_card_expiration_date: '2000-01-01 00:00:00 -0500', result: "success")
    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 0000000000000000, credit_card_expiration_date: '2000-01-01 00:00:00 -0500', result: "failed")
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "success")
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: 0000000000004444, credit_card_expiration_date: '2005-01-01 00:00:00 -0500', result: "failed")
  end

  describe 'Happy Paths' do
    it "can get the total revenue for a given merchant" do

      get "/api/v1/revenue/merchants/#{@merchant_1.id}"

      expect(response).to be_successful

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(revenue).to be_a(Hash)
      expect(revenue[:data]).to be_a(Hash)

      expect(revenue[:data]).to have_key(:id)
      expect(revenue[:data][:id].to_i).to eq(@merchant_1.id)
      expect(revenue[:data]).to have_key(:type)
      expect(revenue[:data][:type]).to eq("merchant_revenue")
      expect(revenue[:data]).to have_key(:type)
      expect(revenue[:data][:type]).to eq("merchant_revenue")

      expect(revenue[:data]).to have_key(:attributes)
      expect(revenue[:data][:attributes]).to be_a(Hash)
      expect(revenue[:data][:attributes]).to have_key(:revenue)
      expect(revenue[:data][:attributes][:revenue]).to eq(60)
    end
  end
  describe "Sad paths " do
    it "returns an error when given a bad merchant id" do
      id = 12399123
      get "/api/v1/revenue/merchants/#{id}"
      message = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(message["error"]).to eq("No such merchant")
    end
  end
end
