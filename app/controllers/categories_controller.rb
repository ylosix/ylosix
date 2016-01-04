# == Schema Information
#
# Table name: categories
#
#  created_at                     :datetime         not null
#  description_translations       :hstore           default({}), not null
#  enabled                        :boolean          default(FALSE)
#  href_translations              :hstore           default({}), not null
#  id                             :integer          not null, primary key
#  meta_tags_translations         :hstore           default({}), not null
#  name_translations              :hstore           default({}), not null
#  parent_id                      :integer
#  priority                       :integer          default(1), not null
#  reference_code                 :string
#  short_description_translations :hstore           default({}), not null
#  show_action_name               :string
#  slug_translations              :hstore           default({}), not null
#  updated_at                     :datetime         not null
#  visible                        :boolean          default(TRUE)
#
# Indexes
#
#  index_categories_on_enabled         (enabled)
#  index_categories_on_parent_id       (parent_id)
#  index_categories_on_reference_code  (reference_code)
#

class CategoriesController < Frontend::CommonController
  before_action :set_category, except: [:index]

  def index
    @categories = Category.root_category.children
  end

  def show
  end

  def tags
    render '/searches/index'
  end

  def append_variables
    super

    if @category
      @liquid_options[:features] = true
      @liquid_options[:tags] = true
      @liquid_options[:tags_groups] = true
      @liquid_options[:current_category] = @category
      @variables['category'] = @category.to_liquid(@liquid_options)

      # Tags by category, removes general tags.
      @variables['tags_group'] = array_to_liquid(TagsGroup.retrieve_groups(@category.id), @liquid_options)
      add_show_action_name(@category)
    end

    @variables['products'] = []
    if params[:slug_tags]
      @variables['products'] = array_to_liquid(products_tags, @liquid_options)
    else
      if @category
        @products = Product.in_frontend(@category).page(params[:page]).per(per_page)

        @variables['products'] = array_to_liquid(@products, @liquid_options)
        @variables['block_paginate'] = div_pagination(@products)
      end
    end

    array_categories = Utils.get_parents_array(@category)
    array_categories.delete_at(0) if array_categories.any?  # delete root.
    array_categories << @category unless @category.nil?     # append current.

    array_categories.each do |category|
      add_breadcrumb(Breadcrumb.new(url: category.href, name: category.name))
    end
  end

  protected

  def products_tags
    tags, _ids, _slugs = set_tags

    groups = {}
    tags.each do |tag|
      groups[tag.tags_group_id] ||= []
      groups[tag.tags_group_id] << tag.id
    end

    products = Product.joins(:products_tags)
    groups.each do |_k, group_tags_ids|
      products = products.where(products_tags: {tag_id: group_tags_ids})
    end

    products.group('products.id')
  end

  def set_breadcrumbs
  end

  def set_category
    @category = nil

    t = Link.arel_table
    link = Link.where(t[:slug].eq(params[:category_id])
                          .or(t[:object_id].eq(params[:category_id]))).take

    fail ActiveRecord::RecordNotEnabled if link && !link.enabled

    @category = Category.find(link.object_id) if link

    fail ActiveRecord::RecordNotFound unless @category
  end
end
