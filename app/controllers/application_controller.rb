class ApplicationController < ActionController::API
  def query_size
    @query_size = params[:per_page] || 20
  end

  def page_count
    @count = params[:page] || 1
  end
end
