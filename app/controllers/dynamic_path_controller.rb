class DynamicPathController < Frontend::CommonController
  def append_variables
    super

    if @product
      @variables['product'] = @product.to_liquid unless @product.nil?

      if @categories # We already have the categories from the path
        @category = @categories.last
      else
        @category = @product.categories.first if @product.categories.any?

        @categories = Utils.get_parents_array(@category)
        @categories.delete_at(0) if @categories.any? # delete root.
        @categories << @category unless @category.nil? # append current.
      end
    else
      @category = @categories.last
    end

    @variables['tags_group'] = TagsGroup.general_groups(@category.id)
    add_show_action_name(@category)

    @categories.each do |category|
      add_breadcrumb(Breadcrumb.new(url: category.href, name: category.name))
    end
  end

  def show_path
    parse_path

    if @product
      render 'products/show'
    else
      render 'categories/show'
    end
  end

  protected

  def set_breadcrumbs
  end

  def parse_path
    segments = params[:path].split('/')

    @product = ProductTranslation.find_by(slug: segments.last).try(:product)
    if @product.present?
      fail ActiveRecord::RecordNotEnabled unless @product.enabled
      segments.pop # Remove last segment
    end

    parse_category_path(segments) if segments.any?
  end

  def parse_category_path(segments)
    @categories = segments.map do |segment|
      category = CategoryTranslation.find_by(slug: segment).try(:category)
      fail ActiveRecord::RecordNotFound if category.blank?
      fail ActiveRecord::RecordNotEnabled if category.present? && !category.enabled
      category
    end

    @categories.each_with_index do |category, i|
      fail ArgumentError if @categories[i + 1].present? && category.id != @categories[i + 1].parent_id
    end

    fail ArgumentError if @product.present? && !@product.categories.include?(@categories.last)
  end
end
