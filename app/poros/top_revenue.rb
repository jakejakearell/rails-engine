class TopRevenue

  attr_reader :id,
              :revenue,
              :name

  def initialize(data)
    @id = data.last[:merchant_id]
    @revenue = data.last[:revenue]
    @name = data.last[:name]
  end

end
