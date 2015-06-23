module Frontend
  class CommonController < ApplicationController
    include CommonModule

    before_action :set_query_text
    before_action :initialize_breadcrumb, :set_breadcrumbs

    private

    def set_query_text
      @query_text = ''
      @query_text = params[:query_text] unless params[:query_text].blank?
    end
  end
end
