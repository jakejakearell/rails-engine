require 'rails_helper'

describe "Rail Engine API-Revenue" do
  #hand rolled data for more control
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

  describe 'Happy Paths' do
    describe "merchant revenue" do
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

    describe "Potential Revenue of Unshipped Orders" do
      it "will return a JSON:API compliant Hash of the potential revenue of unshipped orders" do
        get "/api/v1/revenue/unshipped?quantity=10"
        expect(response).to be_successful

        ranked_potential = JSON.parse(response.body, symbolize_names: true)

        expect(ranked_potential).to be_a(Hash)
        expect(ranked_potential[:data]).to be_a(Array)

        ranked_potential[:data].each do |invoice|
          expect(invoice).to have_key(:id)
          expect(invoice[:id]).to be_a(String)
          expect(invoice).to have_key(:type)
          expect(invoice[:type]).to eq("unshipped_order")
          expect(invoice).to have_key(:attributes)
          expect(invoice[:attributes]).to be_a(Hash)
          expect(invoice[:attributes]).to have_key(:potential_revenue)
          expect(invoice[:attributes][:potential_revenue]).to be_a(Float)
        end
      end

      it "will order the results of merchant potential revenue" do
        get "/api/v1/revenue/unshipped?quantity=10"
        expect(response).to be_successful

        ranked_potential = JSON.parse(response.body, symbolize_names: true)

        first_invoice_total = ranked_potential[:data][0][:attributes][:potential_revenue]
        second_invoice_total = ranked_potential[:data][1][:attributes][:potential_revenue]
        third_invoice_total = ranked_potential[:data][2][:attributes][:potential_revenue]

        expect(first_invoice_total).to be  > second_invoice_total
        expect(second_invoice_total).to be  > third_invoice_total
      end

      it "will return 10 be default" do
        get "/api/v1/revenue/unshipped"
        expect(response).to be_successful

        ranked_potential = JSON.parse(response.body, symbolize_names: true)

        expect(ranked_potential[:data].count).to eq(10)

      end

      it "can show less than 10 results" do
        get "/api/v1/revenue/unshipped?quantity=9"
        expect(response).to be_successful

        ranked_potential = JSON.parse(response.body, symbolize_names: true)

        ranked_potential = JSON.parse(response.body, symbolize_names: true)

        expect(ranked_potential[:data].count).to eq(9)
      end

      it "can show more than 10 results" do
        get "/api/v1/revenue/unshipped?quantity=11"
        expect(response).to be_successful

        ranked_potential = JSON.parse(response.body, symbolize_names: true)

        expect(ranked_potential[:data].count).to eq(11)
      end
    end
  end

  describe "Sad paths " do
    describe "merchant revenue" do
      it "returns an error when given a bad merchant id" do
        id = 12399123
        get "/api/v1/revenue/merchants/#{id}"
        message = JSON.parse(response.body)

        expect(response.status).to eq(404)
        expect(message["error"]).to eq("No such merchant")
      end
    end
  end
end
