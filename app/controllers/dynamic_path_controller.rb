class DynamicPathController < Frontend::CommonController
  def append_variables
    super

    if @product
      @liquid_options[:features] = true
      @liquid_options[:tags] = true
      @variables['product'] = @product.to_liquid(@liquid_options) unless @product.nil?
      add_show_action_name(@product)

    elsif @category
      @liquid_options[:features] = true
      @liquid_options[:tags] = true
      @liquid_options[:tags_groups] = true
      @liquid_options[:current_category] = @category
      @variables['category'] = @category.to_liquid(@liquid_options)

      # Tags by category, removes general tags.
      @variables['tags_group'] = array_to_liquid(TagsGroup.retrieve_groups(@category.id), @liquid_options)
      add_show_action_name(@category)

      @products = Product.in_frontend(@category).page(params[:page]).per(per_page)

      @variables['products'] = array_to_liquid(@products, @liquid_options)
      @variables['block_paginate'] = div_pagination(@products)
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

    @categories = []
    segments.each do |slug|
      link = Link.find_by(slug: slug)

      fail ActiveRecord::RecordNotEnabled if link && !link.enabled
      fail ActiveRecord::RecordNotFound unless link

      case link.class_name
        when 'Category'
          @categories << Category.find(link.object_id)
        when 'Product'
          @product = Product.find(link.object_id)
      end
    end

    # Validate categories order
    @categories.each_with_index do |category, i|
      fail InvalidPathError if @categories[i + 1].present? && category.id != @categories[i + 1].parent_id
    end
  end
end
