require 'rails_helper'

describe "Rail Engine API-Merchants" do
  describe 'Happy Paths' do
    it "sends a list of the first 20 merchants by default" do
      create_list(:merchant, 100)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.count).to be(20)
      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(Integer)

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)
      end
    end

    it "a user can request a longer list of merchants" do
      create_list(:merchant, 100)

      get '/api/v1/merchants?per_page=50'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.count).to be(50)
      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(Integer)

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)
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
      expect(merchants.first).to eq(merchants_copy.first)
      expect(merchants.last).to eq(merchants_copy.last)

      expect(merchants.first).not_to eq(merchants_new_page.first)
      expect(merchants.last).not_to eq(merchants_new_page.last)

      expect(merchants.count).to eq(20)
      expect(merchants_copy.count).to eq(20)
      expect(merchants_new_page.count).to eq(20)

      expect(merchants.first.class).to eq(Hash)
      expect(merchants_copy.first.class).to eq(Hash)
      expect(merchants_new_page.first.class).to eq(Hash)
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
      expect(merchants.first).to eq(merchants_copy.first)
      expect(merchants.last).to eq(merchants_copy.last)

      expect(merchants.first).not_to eq(merchants_new_page.first)
      expect(merchants.last).not_to eq(merchants_new_page.last)

      expect(merchants.count).to eq(23)
      expect(merchants_copy.count).to eq(23)
      expect(merchants_new_page.count).to eq(23)

      expect(merchants.first.class).to eq(Hash)
      expect(merchants_copy.first.class).to eq(Hash)
      expect(merchants_new_page.first.class).to eq(Hash)
    end
  end

  describe 'sad paths' do
    it "will send an empty array when a page does not exist" do
      create_list(:merchant, 100)

      get '/api/v1/merchants'

      expect(response).to be_successful


      end
  end
end
