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

ActiveAdmin.register Category do
  menu parent: 'Catalog'
  permit_params do
    permitted = [:parent_id, :reference_code, :enabled, :visible, :meta_keywords,
                 :meta_description, :show_action_name, :priority]

    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {name_translations: locales}
    permitted << {short_description_translations: locales}
    permitted << {description_translations: locales}
    permitted << {slug_translations: locales}
    permitted << {meta_tags_translations: locales}

    permitted
  end

  action_item :view, only: :show do
    link_to t('formtastic.add_another', model: t('activerecord.models.category.one')), new_admin_category_path
  end

  action_item :view, only: [:show, :edit] do
    link_to 'Public link', category_path(category), target: '_blank' if category
  end

  index do
    selectable_column
    id_column

    column t('activerecord.attributes.category.parent'), sortable: :parent do |category|

      begin
        array = Utils.get_parents_array(category)
        (array.map { |item| auto_link(item, item.name) }).join(' || ').html_safe
      rescue ClassErrors::ParentLoopError
        'Parent loop exception'
      end
    end

    column :name
    column :enabled
    column :visible
    column :slug
    column :priority
    actions
  end

  filter :parent_id,
         label: proc { I18n.t 'activerecord.attributes.category.parent' },
         as: :select,
         collection: proc { category_collection_select }

  filter :by_name_in,
         label: proc { I18n.t 'activerecord.attributes.category.name' },
         as: :string

  filter :enabled
  filter :visible

  filter :by_slug_in,
         label: proc { I18n.t 'activerecord.attributes.category.slug' },
         as: :string

  filter :priority

  form do |f|
    tabs do
      tab t('active_admin.categories.information') do
        f.inputs t('active_admin.categories.information') do
          f.input :reference_code
          f.input :parent_id,
                  label: t('activerecord.attributes.category.parent'),
                  as: :select,
                  include_blank: true,
                  collection: category_collection_select(category)

          f.input :enabled
          f.input :visible

          admin_translation_text_field(category, 'category', 'name_translations')
          admin_translation_text_field(category, 'category', 'short_description_translations', component: ActiveAdminHelper::CK_EDITOR)
          admin_translation_text_field(category, 'category', 'description_translations', component: ActiveAdminHelper::CK_EDITOR)

          f.input :priority, hint: '1:+ --- 10:-'
        end
      end

      tab 'Seo' do
        f.inputs 'Seo' do
          admin_translation_text_field(category, 'category', 'meta_tags_translations')
          admin_translation_text_field(category, 'category', 'slug_translations', hint: 'Chars not allowed: (Upper chars) spaces')
          f.input :show_action_name, hint: 'File name of show render'
        end
      end
    end

    f.actions
  end

  show title: proc { |p| "#{p.name}" } do
    attributes_table do
      row :id
      row :name
      row :parent
      row :enabled
      row :visible
      row :reference_code
      row :created_at
      row :updated_at
      row :priority
      row :show_action_name

      row :description
      row :short_description
      row :meta_tags
      row :slug
      row :href
    end
  end

  controller do
    def render(*args)
      # TODO, not working order by parent
      if @parent_order
        params[:order] = @parent_order
        array_ordered = Category.parent_order(@parent_order)

        ids = array_ordered.map(&:id)
        order_by = ids.map { |i| "id=#{i} DESC" }.join(',')

        per_page = active_admin_config.per_page || 30
        @categories = Category.where(id: ids).order(order_by).page(params[:page]).per(per_page)
      end

      super
    end

    def index
      if params[:order] && params[:order].include?('parent')
        @parent_order = params.delete(:order)
      end

      super
    end
  end
end
