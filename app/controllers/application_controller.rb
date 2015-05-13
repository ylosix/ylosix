class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_query_text, :get_root_categories, :get_default_products
  
  private
  
  def set_query_text
    @query_text = ''
    @query_text = params[:query_text] unless params[:query_text].blank?
  end

  def get_root_categories
    root_category = Category.find_by(:parent_id => nil, :enabled => true)

    @categories = []
    unless root_category.nil?
      @categories = root_category.children.where(:enabled => true,
                                                 :appears_in_web => true)
    end
  end

  def get_default_products
    @products = Product.all.limit(10)
  end
end
