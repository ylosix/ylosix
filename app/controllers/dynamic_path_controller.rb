class DynamicPathController < Frontend::CommonController
  def append_variables
    super

    if @product.present?
      @variables['product'] = @product.to_liquid unless @product.nil?

      if @category.blank?
        @category = @product.categories.first if @product.categories.any?

        @categories = Utils.get_parents_array(@category)
        @categories.delete_at(0) if @categories.any? # delete root.
        @categories << @category unless @category.nil? # append current.
      end
    end

    unless @category.blank?
      @variables['tags_group'] = TagsGroup.retrieve_groups(@category.id)
      add_show_action_name(@category)
    end

    unless @categories.blank?
      @categories.each do |category|
        add_breadcrumb(Breadcrumb.new(url: category.href, name: category.name))
      end
    end
  end

  def show_path
    parse_path

    if @categories
      if @product.present? && @product.categories.any? && !@product.categories.include?(@categories.last)
        fail ClassErrors::InvalidPathError
      end

      @category = @categories.last
    else
      fail ClassErrors::InvalidPathError if @product.present? && @product.categories.any?
    end

    if @product.present?
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
      fail InvalidPathError if @categories[i + 1].present? && category.id != @categories[i + 1].parent_id
    end
  end
end
