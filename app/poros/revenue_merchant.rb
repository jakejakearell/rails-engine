class RevenueMerchant
  attr_reader :id,
              :revenue

  def initialize(data)
    @id = data[:id]
    @revenue = data[:merchant_revenue]
  end

end
