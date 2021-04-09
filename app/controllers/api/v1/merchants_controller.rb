class Api::V1::MerchantsController < ApplicationController

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

  def find_all
    render json: MerchantSerializer.new(Merchant.find_all_by_name(name_query))
  end

  private

  def merchant_id
    params[:id]
  end

  def name_query
    params[:name]
  end
end
