require 'rails_helper'

describe "Rail Engine API-Merchant" do
  describe 'Happy Paths' do
    it "sends a merchant" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to eq(id)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end
  end
end
