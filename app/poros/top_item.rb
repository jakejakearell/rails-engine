class TopItem

  attr_reader :id,
              :count,
              :name

  def initialize(data)
    @id = data.last[:merchant_id]
    @count = data.last[:count]
    @name = data.last[:name]
  end

end
