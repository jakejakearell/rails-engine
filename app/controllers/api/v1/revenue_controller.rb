class Api::V1::RevenueController < ApplicationController

  def merchant_revenue
    begin
      merchant = Merchant.total_revenue(merchant_id)
      merchant = RevenueMerchant.new(merchant)
      render json: MerchantRevenueSerializer.new(merchant)
    rescue ActiveRecord::RecordNotFound
      render json: {error: "No such merchant",status: 404}, status: 404
    end
  end

  def potential_revenue
    invoices = RevenueFacade.unshipped_invoices(quantity)
    render json: UnshippedOrderSerializer.new(invoices)
  end

  def most_revenue_merchants
    if quantity_merchants
      merchants = RevenueFacade.top_merchants_revenue(quantity_merchants)
      render json: MerchantNameRevenueSerializer.new(merchants)
    else
      render json: {error: "Bad params",status: 400}, status: 400
    end
  end

  private

  def merchant_id
    params[:id]
  end

  def quantity_merchants
    if params[:quantity].nil? || params[:quantity].to_i == 0
      false
    else
      params[:quantity].to_i
    end
  end
end
