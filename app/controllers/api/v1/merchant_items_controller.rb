class Api::V1::MerchantItemsController < ApplicationController
  # before_action :page_count

  def index
    render json: MerchantSerializer.new(
      Merchant.find(params[:id]).items
    )
  end
end
