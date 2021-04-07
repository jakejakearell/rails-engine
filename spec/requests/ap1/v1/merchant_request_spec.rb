require 'rails_helper'

describe "Rail Engine API-Merchant" do
  describe 'Happy Paths' do
    it "sends a merchant" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchant).to be_a(Hash)
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a(Hash)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_a(String)

      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data][:type]).to eq('merchant')

      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to be_a(Hash)

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end

    it "sends all items that belong to a merchant" do
      merchant = create(:merchant)
      items = create_list(:item, 34)

      items.each do |item|
        item.update({:merchant_id => merchant.id})
      end

      get "/api/v1/merchants/#{merchant.id}/items"
      merchant_items = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_items).to be_a(Hash)
      expect(merchant_items[:data]).to be_a(Array)
      expect(merchant_items[:data].count).to be(34)

      merchant_items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)
        expect(item).to have_key(:type)
        expect(item[:type]).to eq("item")
        expect(item).to have_key(:attributes)

        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end
  end

  describe 'Sad Paths' do
    it "sends a 404 when an invalid id is sent for merchant endpoint" do
      id = 12399123
      get "/api/v1/merchants/#{id}"
      message = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(message["error"]).to eq("No such merchant")
    end

    it "sends a 404 when an invalid id is sent for a merchant's items" do
      id = 12399123
      get "/api/v1/merchants/#{id}/items"
      message = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(message["error"]).to eq("No such merchant")
    end
  end
end
