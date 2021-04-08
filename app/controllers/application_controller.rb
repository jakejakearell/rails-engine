class ApplicationController < ActionController::API
  def query_size
    @query_size = params[:per_page] || 20
  end

  def page_count
    @count = params[:page] || 0
  end

  def quantity
    @count = params[:quantity] || 10
  end


  def page_offset
    if page_count.to_i == 0
      0
    else
      (query_size.to_i) * (page_count.to_i - 1)
    end
  end
end
