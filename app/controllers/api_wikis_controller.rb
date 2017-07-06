class ApiWikisController < ApplicationController
  before_action :set_wiki

  # GET /*relative_path
  def show
    render json: @api_wiki, serializer: VisibleWikiSerializer
  end

  private
  def set_wiki
    @api_wiki = ApiWiki.find_by(slug: params[:slug])
  end
end
