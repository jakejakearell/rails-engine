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

  private

  def item_id
    params[:id]
  end
end
