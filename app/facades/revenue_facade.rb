class RevenueFacade
  def self.potential_revenue_list(quantity)
    Invoice.potential_revenue(quantity)
  end

  def self.data_about_invoices(quantity)
    list = RevenueFacade.potential_revenue_list(quantity)
    list.reduce(Hash.new) do |memo, merch|
      memo[:"#{merch.id}"] = {potential_revenue: merch.merchant_untapped,
                              id: merch.id}
      memo
    end
  end

  def self.unshipped_invoices(quantity)
    data = RevenueFacade.data_about_invoices(quantity)
    data.map do |data|
      UnshippedOrder.new(data)
    end
  end
end
