class Api::V1::ItemMerchantsController < ApplicationController
  # before_action :page_count

  def index
    # I would like to abstract out the Merchant items method a bit
    render json: MerchantSerializer.new(Item.find(params[:id]).merchant)
  end
end
