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

  private

  def merchant_id
    params[:id]
  end
end
