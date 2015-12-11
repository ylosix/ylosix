class HomeController < Frontend::CommonController
  def index
    @category = Category.find_by(parent_id: nil)
  end

  def append_variables
    super

    if @category
      @variables['category'] = @category.to_liquid

      # Tags by category, removes general tags.
      @variables['tags_group'] = TagsGroup.retrieve_groups(@category.id)
      add_show_action_name(@category)
    end
  end

  protected

  def set_breadcrumbs
  end
end
