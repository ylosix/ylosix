module InitializeSlug
  def generate_slug(name, array_translations, field_translation = nil)
    slug = 'needs-to-be-changed'
    if !name.blank?
      slug = name
    elsif !field_translation.blank? && array_translations.any? && !array_translations.first.name.blank?
      slug = array_translations.first[field_translation]
    end

    parse_url_chars(slug)
  end

  def parse_url_chars(str)
    out = str.downcase
    out = out.tr(' ', '-')

    out = URI.encode(out)
    out.gsub('%23', '#') # Restore hashtags
  end

  def href(object)
    href = object.slug

    if !object.slug.start_with?('#') && !object.slug.start_with?('http')
      helpers = Rails.application.routes.url_helpers

      if object.class == Category
        href = helpers.show_slug_categories_path(object.slug)
      elsif object.class == Product
        href = helpers.show_slug_products_path(object.slug)
        if object.categories.any?
          href = helpers.show_product_slug_categories_path(object.categories.first.slug, object.slug)
        end
      end
    end

    href
  end
end
