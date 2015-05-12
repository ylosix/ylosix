class WelcomeController < ApplicationController
  def index
    root_category = Category.find_by(:parent_id => nil, :enabled => true)

    @categories = []
    unless root_category.nil?
      @categories = root_category.children.where(:enabled => true,
                                                 :appears_in_web => true)
    end
  end
end
