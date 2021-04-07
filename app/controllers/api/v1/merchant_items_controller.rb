class Api::V1::MerchantItemsController < ApplicationController

  def index
    begin
      # I would like to abstract out the Merchant items method a bit
      render json: ItemSerializer.new(Merchant.find(params[:id]).items)
    rescue ActiveRecord::RecordNotFound
      render json: {error: "No such merchant",status: 404}, status: 404
    end
  end
end
