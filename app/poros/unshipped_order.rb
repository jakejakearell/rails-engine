class UnshippedOrder
  attr_reader :id,
              :potential_revenue

  def initialize(data)
    @id = data.last[:id]
    @potential_revenue = data.last[:potential_revenue]
  end
  
end
