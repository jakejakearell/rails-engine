require 'rails_helper'

RSpec.describe UnshippedOrder do
  describe 'happy path' do
    it 'has attributes of id, merchant_revenue and is a UnshippedOrder object' do
      data = [44 , {:id=>44,
              :potential_revenue=> 123.99
              }]

      result = UnshippedOrder.new(data)
      expect(result).to be_a(UnshippedOrder)
      expect(result.id).to eq(44)
      expect(result.potential_revenue).to eq(123.99)
    end
  end
end
