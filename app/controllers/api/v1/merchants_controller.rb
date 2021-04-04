class Api::V1::MerchantsController < ApplicationController
  # before_action :page_count

  def index
    render json: MerchantSerializer.new(Merchant.all
    .limit(query_size)
    .offset(page_offset)
    )
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(merchant_id))
  end

  private

  def merchant_id
    params[:id]
  end

  def page_offset
    if page_count.to_i == 0
      (query_size.to_i) * (page_count.to_i)
    else
      (query_size.to_i) * (page_count.to_i - 1)
    end
  end
end
