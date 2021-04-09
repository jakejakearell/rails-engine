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

  def find
    item = RevenueFacade.item_selector(find_params)
    if item == []
      render json: ItemSerializer.new(Item.new)
    elsif item
      render json: ItemSerializer.new(item[0])
    else
      render json: {error: "Bad params",status: 400}, status: 400
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
    if item.update(item_params)
      render json: ItemSerializer.new(item)
    else
      render json: {error: "Bad params",status: 404}, status: 404
    end
  end

  def destroy
    begin
      Item.destroy(item_id)
      render json: {body: "Item destroyed",status: 202}, status: 202
    rescue ActiveRecord::RecordNotFound
      render json: {error: "No such item",status: 404}, status: 404
    end
  end

  private
    def item_id
      params[:id]
    end

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id )
    end

    def find_params
      params.permit(:name, :min_price, :max_price)
    end
end
