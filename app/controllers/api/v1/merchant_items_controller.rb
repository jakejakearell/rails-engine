class Api::V1::MerchantItemsController < ApplicationController
  # before_action :page_count

  def index
    merchant_items = render json:MerchantSerializer.new(
                Merchant.find(params[:id])
                )
    merchant_items = JSON.parse(merchant_items)
    merchant_items = merchant_items["data"]["relationships"]["items"]["data"]
    hope_you_work = merchant_items.reduce([]) do |memo, item|
      memo << ItemSerializer.new(Item.find(item["id"]))
    end
  end
end
