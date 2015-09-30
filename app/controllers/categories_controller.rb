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

    unless @category.nil?
      @variables['category'] = @category.to_liquid unless @category.nil?

      # Tags by category, removes general tags.
      @variables['tags_group'] = TagsGroup.general_groups(@category.id)
      add_show_action_name(@category)
    end

    @variables['products'] = []
    if params[:slug_tags].blank?
      @variables['products'] = array_to_liquid(Product.in_frontend(@category)) unless @category.nil?
    else
      @variables['products'] = array_to_liquid(products_tags)
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

    category_id = params[:slug]
    category_id ||= params[:category_id]

    unless category_id.blank?
      attributes = {enabled: true, id: category_id}
      @category = Category.find_by(attributes)

      if @category.nil?
        attributes = {enabled: true, category_translations: {slug: category_id}}
        @category = Category.with_translations.find_by(attributes)
      end
    end

    fail ActiveRecord::RecordNotFound if @category.blank?
    fail ActiveRecord::RecordNotEnabled if @category && !@category.enabled
  end
end
