class Api::V1::MerchantsController < ApplicationController
  # before_action :page_count

  def index
    render json: Merchant.all.limit(query_size).offset((query_size.to_i * page_count.to_i))
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
