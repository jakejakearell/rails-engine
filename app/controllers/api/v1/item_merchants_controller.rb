class Api::V1::ItemMerchantsController < ApplicationController

  def index
    begin
      render json: MerchantSerializer.new(Item.find(params[:id]).merchant)
    rescue ActiveRecord::RecordNotFound
      render json: {error: "No such item",status: 404}, status: 404
    end
  end
end
