class Api::V1::ItemsController < ApplicationController
  # before_action :page_count

  def index
    render json: ItemSerializer.new(Item.all
    .limit(query_size)
    .offset(page_offset)
    )
  end

  def show
    render json: ItemSerializer.new(Item.find(item_id))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)), status: 201
  end

  def update

  end

  private

  def item_id
    params[:id]
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id )
  end
end
