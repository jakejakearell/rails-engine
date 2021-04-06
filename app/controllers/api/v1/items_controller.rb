class Api::V1::ItemsController < ApplicationController
  # before_action :page_count

  def index
    render json: ItemSerializer.new(Item.all
    .limit(query_size)
    .offset(page_offset)
    )
  end

  def show
  end
end
