require 'rails_helper'

describe "Rail Engine API-Revenue" do
  #hand rolled data for more control
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
        expect(revenue[:data][:attributes][:revenue]).to eq(24)
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

      it "will return 10 by default" do
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

    describe "Merchants with most Revenue" do
      it "will show a specified quantity of merchants ranked by revenue" do

        get '/api/v1/revenue/merchants?quantity=2'
        expect(response).to be_successful

        merchant_revenue_rank = JSON.parse(response.body, symbolize_names: true)
        expect(merchant_revenue_rank).to be_a(Hash)
        expect(merchant_revenue_rank[:data]).to be_a(Array)
        expect(merchant_revenue_rank[:data].count).to eq(2)

        merchant_revenue_rank[:data].each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_a(String)
          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to eq("merchant_name_revenue")
          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_a(Hash)
          expect(merchant[:attributes]).to have_key(:revenue)
          expect(merchant[:attributes][:revenue]).to be_a(Float)
          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a(String)
        end
      end
    end

    describe "Merchants with most items sold" do
      it "will show a specified quantity of merchants ranked by items sold" do

        get '/api/v1/merchants/most_items?quantity=2'
        expect(response).to be_successful

        merchant_items = JSON.parse(response.body, symbolize_names: true)
        expect(merchant_items).to be_a(Hash)
        expect(merchant_items[:data]).to be_a(Array)
        expect(merchant_items[:data].count).to eq(2)

        merchant_items[:data].each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_a(String)
          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to eq("items_sold")
          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_a(Hash)
          expect(merchant[:attributes]).to have_key(:count)
          expect(merchant[:attributes][:count]).to be_a(Integer)
          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a(String)
        end
      end
    end
  end

  describe "Sad paths " do
    describe "Merchants with most Revenue" do
      it "will all merchants when quantity too large" do

        get '/api/v1/revenue/merchants?quantity=300'
        expect(response).to be_successful

        merchant_revenue_rank = JSON.parse(response.body, symbolize_names: true)
        expect(merchant_revenue_rank).to be_a(Hash)
        expect(merchant_revenue_rank[:data]).to be_a(Array)
        expect(merchant_revenue_rank[:data].count).to eq(4)
    end

    it "returns an error when given a string for quantity" do

      get "/api/v1/revenue/merchants?quantity=frongs"
      message = JSON.parse(response.body)

      expect(response.status).to eq(400)
      expect(message["error"]).to eq("Bad params")
    end

    it "returns an error when given no quantity" do

      get "/api/v1/revenue/merchants"
      message = JSON.parse(response.body)

      expect(response.status).to eq(400)
      expect(message["error"]).to eq("Bad params")
    end
  end

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
