require 'rails_helper'

describe "Rail Engine API" do
    it "sends a list of merchants" do
      create_list(:merchant, 50)

      get '/api/v1/merchants'

      expect(response).to be_successful
    end
end
