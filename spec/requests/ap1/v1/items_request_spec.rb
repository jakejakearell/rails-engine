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
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
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
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it "a user can request a different page" do
      create_list(:item, 100)

      get '/api/v1/items?page=1'
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/items?page=1'
      expect(response).to be_successful
      items_copy = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/items?page=2'
      expect(response).to be_successful
      items_new_page = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].first).to eq(items_copy[:data].first)
      expect(items[:data].last).to eq(items_copy[:data].last)

      expect(items[:data].first).not_to eq(items_new_page[:data].first)
      expect(items[:data].last).not_to eq(items_new_page[:data].last)

      expect(items[:data].count).to eq(20)
      expect(items_copy[:data].count).to eq(20)
      expect(items_new_page[:data].count).to eq(20)

      expect(items[:data].first.class).to eq(Hash)
      expect(items_copy[:data].first.class).to eq(Hash)
      expect(items_new_page[:data].first.class).to eq(Hash)
    end

    it "a user can request a different page and a more than 20 responses" do
      create_list(:item, 100)

      get '/api/v1/items?page=1&per_page=23'
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/items?page=1&per_page=23'
      expect(response).to be_successful
      items_copy = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/items?page=2&per_page=23'
      expect(response).to be_successful
      items_new_page = JSON.parse(response.body, symbolize_names: true)

      # Don't know if I need to assert the copies are the same.
      expect(items[:data].first).to eq(items_copy[:data].first)
      expect(items[:data].last).to eq(items_copy[:data].last)

      expect(items[:data].first).not_to eq(items_new_page[:data].first)
      expect(items[:data].last).not_to eq(items_new_page[:data].last)

      expect(items[:data].count).to eq(23)
      expect(items_copy[:data].count).to eq(23)
      expect(items_new_page[:data].count).to eq(23)

      expect(items[:data].first.class).to eq(Hash)
      expect(items_copy[:data].first.class).to eq(Hash)
      expect(items_new_page[:data].first.class).to eq(Hash)
    end
  end

  describe 'sad paths' do
    it "will send an empty array when a page does not exist" do
      create_list(:item, 100)

      get '/api/v1/items?page=250'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].empty?).to be(true)
    end

    it "a user requests more items than exist it will return all items" do
      create_list(:item, 53)

      get '/api/v1/items?per_page=69'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].count).to be(53)
    end
  end
end
