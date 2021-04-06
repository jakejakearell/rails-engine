class Api::V1::MerchantItemsController < ApplicationController
  # before_action :page_count

  def index
    # I would like to abstract out the Merchant items method a bit
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end
end
