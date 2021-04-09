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

  def self.sanatize_active_record_data(limit)
    Merchant.most_revenue
    .sort_by(&:last)
    .reverse[0..(limit-1)]
  end


  def self.top_merchants_poro_data(limit)
    merchant_info = RevenueFacade.sanatize_active_record_data(limit)
    merchant_info.reduce(Hash.new) do |memo, merchant|
      memo[merchant[0]] = {merchant_id: merchant[0],
                           name: Merchant.merchant_name(merchant[0]),
                           revenue: merchant[1]}
      memo
    end
  end

  def self.top_merchants_revenue(quantity)
    data = RevenueFacade.top_merchants_poro_data(quantity)
    data.map do |data|
      TopRevenue.new(data)
    end
  end


  def self.item_selector(info)
    if info[:name] && info[:min_price] && info[:max_price]
      false
    elsif info[:max_price].to_i < 0 || info[:min_price].to_i < 0
      false
    elsif info[:name] && info[:min_price] || info[:name] && info[:max_price]
      false
    elsif info[:name]
      Item.find_one_by_name(info[:name])
    elsif info[:min_price] && info[:max_price]
      Item.find_one_by_price_range(info[:min_price], info[:max_price])
    elsif info[:min_price]
      Item.find_one_by_min_price(info[:min_price])
    elsif info[:max_price]
      Item.find_one_by_max_price(info[:max_price])
    end
  end

  def self.sanatize_active_record_data_items(limit)
    Merchant.most_sales
    .sort_by(&:last)
    .reverse[0..(limit-1)]
  end

  def self.top_merchant_items_poro_data(limit)
    merchant_info = RevenueFacade.sanatize_active_record_data_items(limit)
    merchant_info.reduce(Hash.new) do |memo, merchant|
      memo[merchant[0]] = {merchant_id: merchant[0],
                           name: Merchant.merchant_name(merchant[0]),
                           count: merchant[1]}
      memo
    end
  end

  def self.top_merchants_items(quantity)
    data = RevenueFacade.top_merchant_items_poro_data(quantity)
    data.map do |data|
      TopItem.new(data)
    end
  end
end
