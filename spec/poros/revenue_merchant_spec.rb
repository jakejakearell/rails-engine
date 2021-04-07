require 'rails_helper'

RSpec.describe RevenueMerchant do
  describe 'happy path' do
    it 'has attributes of id, merchant_revenue and is a RevenueMerchant object' do
      data = {:id=>5123,
              :merchant_revenue=> 900,
              }

      result = RevenueMerchant.new(data)

      expect(result).to be_a(RevenueMerchant)
      expect(result.id).to eq(5123)
      expect(result.revenue).to eq(900)
    end
  end
end
