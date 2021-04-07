require 'rails_helper'

describe "Rail Engine API-Item" do
  describe 'Happy Paths' do
    it "sends a item" do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(item).to be_a(Hash)
      expect(item).to have_key(:data)
      expect(item[:data]).to be_a(Hash)

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_a(String)

      expect(item[:data]).to have_key(:type)
      expect(item[:data][:type]).to eq('item')

      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)
      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
    end

    it "can create a new item" do
      merchant_id = create(:merchant).id
      item_params = ({
                      name: 'Shiny Fork',
                      description: 'Only missing one prong',
                      unit_price: 10.99,
                      merchant_id: merchant_id
                    })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

      created_item = Item.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

      Item.last.delete
    end

    it "can update an item" do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: "The Big Dog" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("The Big Dog")
    end

    it "can destroy an item" do
      item = create(:item)

      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item.id}"
      message = JSON.parse(response.body)

      expect(response).to be_successful
      expect(message["body"]).to eq("Item destroyed")
      expect(Item.count).to eq(0)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "sends the merchant that belong to an item" do
      merchant = create(:merchant)
      items = create_list(:item, 34)

      items.each do |item|
        item.update({:merchant_id => merchant.id})
      end

      get "/api/v1/items/#{items.first.id}/merchant"
      items_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(items_merchant).to be_a(Hash)
      
      expect(items_merchant[:data]).to be_a(Hash)
      expect(items_merchant[:data]).to have_key(:id)
      expect(items_merchant[:data][:id]).to be_a(String)
      expect(items_merchant[:data][:id].to_i).to eq(merchant.id)
      expect(items_merchant[:data]).to have_key(:type)
      expect(items_merchant[:data][:type]).to eq("merchant")

      expect(items_merchant[:data]).to have_key(:attributes)
      expect(items_merchant[:data][:attributes]).to be_a(Hash)
      expect(items_merchant[:data][:attributes]).to have_key(:name)
      expect(items_merchant[:data][:attributes][:name]).to eq(merchant.name)
    end
  end

  describe 'Sad Paths' do
    it "sends a 404 when an invalid id is sent" do
      id = 12399123
      get "/api/v1/items/#{id}"
      message = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(message["error"]).to eq("No such item")
    end

    it "doesn't create an item with missing attributes" do
      item_params = ({
                      name: 'Shiny Fork',
                      description: 'Only missing one prong'
                    })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      message = JSON.parse(response.body)

      expect(response.status).to eq(406)
      expect(message["error"]).to eq("Missing item parameters")
    end
  end
end
