class Api::V1::ItemsController < ApplicationController
  # before_action :page_count

  def index
    render json: ItemSerializer.new(Item.all
    .limit(query_size)
    .offset(page_offset)
    )
  end

  def show
    begin
      render json: ItemSerializer.new(Item.find(item_id))
    rescue ActiveRecord::RecordNotFound
      render json: {error: "No such item",status: 404}, status: 404
    end
  end

  def create
    # this feels brittle
    if item_params.keys.count !=4
      render json: {error: "Missing item parameters",status: 406}, status: 406
    else
      render json: ItemSerializer.new(Item.create(item_params)), status: 201
    end
  end

  def update
    item = Item.find(item_id)
    item.update(item_update)
    render json: ItemSerializer.new(Item.find(item_id))
  end

  def destroy
    Item.destroy(item_id)
    render json: {body: "Item destroyed",status: 202}, status: 202
  end

  private
  def item_id
    params[:id]
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id )
  end

  def item_update
    params.require(:item).permit(:name, :description, :unit_price)
  end

end
