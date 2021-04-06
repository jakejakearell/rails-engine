class Api::V1::MerchantsController < ApplicationController
  # before_action :page_count

  def index
    render json: MerchantSerializer.new(Merchant.all
    .limit(query_size)
    .offset(page_offset)
    )
  end

  def show
    begin
      render json: MerchantSerializer.new(Merchant.find(merchant_id))
    rescue ActiveRecord::RecordNotFound
      render json: {error: "No such merchant",status: 404}, status: 404
    end
  end

  private

  def merchant_id
    params[:id]
  end
end
