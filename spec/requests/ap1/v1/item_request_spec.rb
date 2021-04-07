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

    end

    xit "can destroy an item" do

      delete "/api/v1/items", params: JSON.generate(item: item_params)

      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
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
