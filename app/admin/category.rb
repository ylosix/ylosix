ActiveAdmin.register Category do
  menu parent: 'Catalog'
  permit_params do
    permitted = [:parent_id, :reference_code, :enabled, :visible, :meta_keywords,
                 :meta_description, :show_action_name, :priority]

    cta = [:id, :locale, :name, :short_description, :description, :slug]
    if !params[:category].blank? && !params[:category][:category_translations_attributes].blank?
      unless params[:category][:category_translations_attributes]['0'][:meta_tags].blank?
        meta_tags = params[:category][:category_translations_attributes]['0'][:meta_tags].keys
        cta << {meta_tags: meta_tags}
      end
    end
    permitted << {category_translations_attributes: cta}

    permitted
  end

  action_item :view, only: :show do
    link_to t('formtastic.add_another', model: t('activerecord.models.category.one')), new_admin_category_path
  end

  action_item :view, only: [:show, :edit] do
    link_to 'Public link', category_path(category.slug), target: '_blank'
  end

  index do
    selectable_column
    id_column

    column t('activerecord.attributes.category.parent'), sortable: :parent do |category|
      array = Utils.get_parents_array(category)
      (array.map { |item| auto_link(item, item.name) }).join(' || ').html_safe
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
         include_blank: true,
         collection: proc { category_collection_select }
  filter :translations_name, as: :string, label: proc { I18n.t 'activerecord.attributes.category.name' }
  filter :enabled
  filter :visible
  filter :translations_slug, as: :string, label: proc { I18n.t 'activerecord.attributes.category.slug' }
  filter :priority

  form do |f|
    translations = Utils.array_translations(CategoryTranslation,
                                            {category_id: category.id},
                                            meta_tags: {keywords: '', description: ''})

    f.inputs t('formtastic.edit_form', model: t('activerecord.models.category.one')) do
      f.input :reference_code
      f.input :parent_id,
              label: t('activerecord.attributes.category.parent'),
              as: :select,
              include_blank: true,
              collection: category_collection_select

      f.input :enabled
      f.input :visible

      admin_translation_text_field(translations, 'category', 'name')
      admin_translation_text_field(translations, 'category', 'short_description', component: ActiveAdminHelper::CKEDITOR)
      admin_translation_text_field(translations, 'category', 'description', component: ActiveAdminHelper::CKEDITOR)

      f.input :priority, hint: '1:+ --- 10:-'
    end

    f.inputs 'Seo' do
      admin_translation_text_field(translations, 'category', 'meta_tags')
      admin_translation_text_field(translations, 'category', 'slug', hint: 'Chars not allowed: (Upper chars) spaces')
      f.input :show_action_name, hint: 'File name of show render'
    end

    f.actions
  end

  controller do
    def render(*args)
      unless @parent_order.blank?
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
      @parent_order = ''
      if !params[:order].nil? && params[:order].include?('parent')
        @parent_order = params.delete(:order)
      end

      super
    end
  end
end
