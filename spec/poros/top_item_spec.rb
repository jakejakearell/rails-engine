require 'rails_helper'

RSpec.describe TopItem do
  describe 'happy path' do
    it 'has attributes of merchant_id, count and is a TopItem object' do
      data = [65 , {:merchant_id=>12,
              :count=> 123,
              :name => "Chudley"
              }]

      result = TopItem.new(data)
      expect(result).to be_a(TopItem)
      expect(result.id).to eq(12)
      expect(result.count).to eq(123)
      expect(result.name).to eq("Chudley")
    end
  end
end
