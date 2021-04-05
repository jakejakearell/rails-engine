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
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}/items"

      merchant = JSON.parse(response.body, symbolize_names: true)
      require "pry"; binding.pry
    end
  end

  describe 'Sad Paths' do
    xit "sends a 404 when an invalid id is sent" do
      id = 12399123

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

    end
  end
end
