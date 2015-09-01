ActiveAdmin.register Category do
  menu parent: 'Catalog'
  permit_params :parent_id, :name, :enabled, :visible, :meta_keywords,
                :meta_description, :slug, :show_action_name, :priority,
                category_translations_attributes:
                    [:id, :locale, :name, :short_description, :description]

  index do
    selectable_column
    id_column

    column 'Parent', sortable: :parent do |category|
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

  filter :translations_name, as: :string, label: 'Name'
  filter :visible
  filter :parent

  form do |f|
    f.inputs 'Category Details' do
      f.input :parent
      f.input :enabled
      f.input :visible

      translations = Utils.array_translations(CategoryTranslation, category_id: category.id)
      admin_translation_text_field(translations, 'category', 'name')
      admin_translation_text_field(translations, 'category', 'short_description', ActiveAdminHelper::CKEDITOR)
      admin_translation_text_field(translations, 'category', 'description', ActiveAdminHelper::CKEDITOR)

      f.input :meta_keywords
      f.input :meta_description
      f.input :slug, hint: 'Chars not allowed: (Upper chars) spaces'
      f.input :show_action_name, hint: 'File name of show render'
      f.input :priority, hint: '1:+ --- 10:-'
    end

    f.actions
  end

  controller do
    def render(*args)
      unless @parent_order.blank?
        array_ordered = @categories.to_a.sort do |x, y|
          if @parent_order == 'parent_desc'
            Utils.get_parents_array(y).map(&:name).join('_') <=> Utils.get_parents_array(x).map(&:name).join('_')
          elsif @parent_order == 'parent_asc'
            Utils.get_parents_array(x).map(&:name).join('_') <=> Utils.get_parents_array(y).map(&:name).join('_')
          end
        end

        params[:order] = @parent_order

        ids = array_ordered.map(&:id)
        order_by = ids.map { |i| "id=#{i} DESC" }.join(',')
        @categories = Category.where(id: ids).order(order_by).page(0).per(@categories.size)
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
