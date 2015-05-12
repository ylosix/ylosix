class WelcomeController < ApplicationController
  def index
    root_category = Category.find_by(:parent_id => nil, :enabled => true)

    @categories = []
    @categories = root_category.children.where(:enabled => true) unless root_category.nil?
  end
end
