class Api::V1::MerchantItemsController < ApplicationController
  
  def index
    # I would like to abstract out the Merchant items method a bit
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end
end
