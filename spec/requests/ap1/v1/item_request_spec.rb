require 'rails_helper'

describe "Rail Engine API-Items" do
  describe 'Happy Paths' do
    it "sends a list of the first 20 items by default" do
      create_list(:item, 100)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].count).to be(20)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq("item")

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
      end
    end

    it "a user can request a longer list of items" do
      create_list(:item, 100)

      get '/api/v1/items?per_page=50'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].count).to be(50)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq("item")

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
      end
    end

    it "a user requests more items than exist it will return all items" do
    end

    it "a user can request a different page and a more than 20 responses" do
    end
  end

  describe 'sad paths' do
    it "will send an empty array when a page does not exist" do
    end
  end
end
