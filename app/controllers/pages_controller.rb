class PagesController < ApplicationController
  before_action :set_page

  # GET /*relative_path
  def show
    render json: @page, serializer: VisiblePageSerializer
  end

  private
  def set_page
    @page = Page.find_by(relative_path: params[:relative_path])
  end
end
