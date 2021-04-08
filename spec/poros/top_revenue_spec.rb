require 'rails_helper'

RSpec.describe TopRevenue do
  describe 'happy path' do
    it 'has attributes of merchant_id, merchant_revenue and is a TopRevenue object' do
      data = [65 , {:merchant_id=>65,
              :revenue=> 5230.23,
              :name => "Chudley"
              }]

      result = TopRevenue.new(data)
      expect(result).to be_a(TopRevenue)
      expect(result.id).to eq(65)
      expect(result.revenue).to eq(5230.23)
      expect(result.name).to eq("Chudley")
    end
  end
end
