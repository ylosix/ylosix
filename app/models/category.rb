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

class Category < ActiveRecord::Base
  has_paper_trail

  include ArrayLiquid
  include InitializeSlug

  translates :name, :short_description, :description, :slug, :href, :meta_tags

  # TODO put children in schema erd!
  # has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'

  has_many :products_categories
  has_many :products, through: :products_categories

  has_many :tags_groups_categories
  has_many :tags_groups, through: :tags_groups_categories

  scope :are_enabled, -> { where(enabled: true) }
  scope :in_frontend, lambda {
    where(enabled: true, visible: true)
        .order(:priority)
  }

  after_save :save_global_slug
  default_scope { includes(:products) }

  ransacker :by_name, formatter: lambda { |search|
    ids = Category.where('lower(categories.name_translations->?) LIKE lower(?)', I18n.locale, "%#{search}%").pluck(:id)
    ids.any? ? ids : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :by_slug, formatter: lambda { |search|
    ids = Category.where('lower(categories.slug_translations->?) LIKE lower(?)', I18n.locale, "%#{search}%").pluck(:id)
    ids.any? ? ids : nil
  } do |parent|
    parent.table[:id]
  end

  def self.parent_order(parent_order = 'parent_asc')
    array_ordered = Category.all.sort do |x, y|
      begin
        if parent_order == 'parent_desc'
          Utils.get_parents_array(y).map(&:name).join('_') <=> Utils.get_parents_array(x).map(&:name).join('_')
        elsif parent_order == 'parent_asc'
          Utils.get_parents_array(x).map(&:name).join('_') <=> Utils.get_parents_array(y).map(&:name).join('_')
        end
      rescue ClassErrors::ParentLoopError
      end
    end

    array_ordered
  end

  def me_and_children
    categories = [self]

    if children.any?
      children.each do |child|
        categories += child.me_and_children
      end
    end

    categories
  end

  def children
    children = Category.in_frontend.where(parent_id: id)
    children.to_a.sort! do |a, b|
      if a.priority == b.priority && !a.name.nil? && !b.name.nil?
        a.name.downcase <=> b.name.downcase
      else
        a.priority <=> b.priority
      end
    end
  end

  def self.root_category
    Category.in_frontend.find_by(parent_id: [nil, 0])
  end

  def self.root_categories
    root_category = Category.root_category

    root_categories = []
    root_categories = root_category.children unless root_category.nil?

    root_categories
  end

  def to_liquid(options = {})
    current_category_id = options[:current_category].id if options[:current_category]

    liquid = {
        'active' => current_category_id == id,
        'name' => name,
        'short_description' => short_description,
        'description' => description,
        'priority' => priority,
        'href' => href,
        'children' => array_to_liquid(children, options),
        'products' => array_to_liquid(retrieve_current_products, options)
    }

    liquid['tags_groups'] = array_to_liquid(tags_groups, options) if options[:tags_groups]
    liquid
  end

  private

  def retrieve_current_products
    filtered_products = products.select { |p| p.enabled && p.visible }
    filtered_products.sort { |x, y| y.publication_date <=> x.publication_date }
  end

  def save_global_slug
    save_slug(:name_translations, self)
  end
end
