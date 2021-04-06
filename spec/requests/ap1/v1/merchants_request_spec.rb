require 'rails_helper'

describe "Rail Engine API-Merchants" do
  describe 'Happy Paths' do
    it "sends a list of the first 20 merchants by default" do
      create_list(:merchant, 100)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a(Hash)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].count).to be(20)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq("merchant")

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it "a user can request a longer list of merchants" do
      create_list(:merchant, 100)

      get '/api/v1/merchants?per_page=50'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a(Hash)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].count).to be(50)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq("merchant")

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it "a user can request a different page" do
      create_list(:merchant, 100)

      get '/api/v1/merchants?page=1'
      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/merchants?page=1'
      expect(response).to be_successful
      merchants_copy = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/merchants?page=2'
      expect(response).to be_successful
      merchants_new_page = JSON.parse(response.body, symbolize_names: true)

      # Don't know if I need to assert the copies are the same.
      expect(merchants[:data].first).to eq(merchants_copy[:data].first)
      expect(merchants[:data].last).to eq(merchants_copy[:data].last)

      expect(merchants[:data].first).not_to eq(merchants_new_page[:data].first)
      expect(merchants[:data].last).not_to eq(merchants_new_page[:data].last)

      expect(merchants[:data].count).to eq(20)
      expect(merchants_copy[:data].count).to eq(20)
      expect(merchants_new_page[:data].count).to eq(20)

      expect(merchants[:data].first.class).to eq(Hash)
      expect(merchants_copy[:data].first.class).to eq(Hash)
      expect(merchants_new_page[:data].first.class).to eq(Hash)
    end

    it "a user can request a different page and a more than 20 responses" do
      create_list(:merchant, 100)

      get '/api/v1/merchants?page=1&per_page=23'
      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/merchants?page=1&per_page=23'
      expect(response).to be_successful
      merchants_copy = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/merchants?page=2&per_page=23'
      expect(response).to be_successful
      merchants_new_page = JSON.parse(response.body, symbolize_names: true)

      # Don't know if I need to assert the copies are the same.
      expect(merchants[:data].first).to eq(merchants_copy[:data].first)
      expect(merchants[:data].last).to eq(merchants_copy[:data].last)

      expect(merchants[:data].first).not_to eq(merchants_new_page[:data].first)
      expect(merchants[:data].last).not_to eq(merchants_new_page[:data].last)

      expect(merchants[:data].count).to eq(23)
      expect(merchants_copy[:data].count).to eq(23)
      expect(merchants_new_page[:data].count).to eq(23)

      expect(merchants[:data].first.class).to eq(Hash)
      expect(merchants_copy[:data].first.class).to eq(Hash)
      expect(merchants_new_page[:data].first.class).to eq(Hash)
    end
  end

  describe 'sad paths' do
    it "will send an empty array when a page does not exist" do
      create_list(:merchant, 100)

      get '/api/v1/merchants?page=250'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a(Hash)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].empty?).to be(true)
    end

    it "a user requests more merchants than exist it will return all merchants" do
      create_list(:merchant, 53)

      get '/api/v1/merchants?per_page=900'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a(Hash)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].count).to be(53)
    end
  end
end
