module Frontend
  class CommonController < ApplicationController
    include CommonModule

    before_action :set_query_text

    private

    def set_query_text
      @query_text = ''
      @query_text = params[:query_text] unless params[:query_text].blank?
    end
  end
end
