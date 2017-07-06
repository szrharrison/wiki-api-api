class Api::V1::PagesController < ApplicationController
  before_action :set_page, except: [:index]
  before_action :authorize_account!

  # GET /api/v1/pages
  def index
    pages = @current_account.api_wikis.pages
    render json: pages, each_serializer: WikiPageSerializer
  end

  # GET /api/v1/pages/*relative_path
  def show
    render json: @page
  end

  # POST /api/v1/pages
  def create
    page = @page.sub_pages.new(page_params)
    if page.save
      render json: page
    else
      render json: { error: page.errors.full_messages }
    end
  end

  # PATCH /api/v1/pages/*relative_path
  def update
    @page.update_attributes(page_params)
    if @page.slug_changed?
      @page.sub_pages.each do |sub_page|
        sub_page.relative_path = @page.relative_path + '/' + sub_page.slug
        sub_page.save
      end
    end
    if @page.save
      render json: @page
    else
      render json: { error: @page.errors.full_messages }
    end
  end

  # DELETE /api/v1/pages/*relative_path
  def delete
    if Page.find(@page.id)
      @page.destroy
      render json: { message: 'Successfully deleted.' }
    else
      render json: { error: 'Sorry, we were unsuccessful in deleting your page' }
    end
  end


  private

  def set_page
    @page = Page.find_by(relative_path: params[:relative_path])
  end

  def page_params
    params.require(:page).permit(:name, :slug)
  end
end
