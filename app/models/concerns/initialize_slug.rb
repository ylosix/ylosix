module InitializeSlug
  def generate_slug(field_translation, array_translations)
    array_translations.each do |translation|
      slug = translation.slug
      if slug.blank?
        slug = 'needs-to-be-changed'

        unless field_translation.blank?
          if !translation[field_translation].blank?
            slug = translation[field_translation]
          elsif array_translations.any? && !array_translations.first[field_translation].blank?
            slug = array_translations.first[field_translation]
          end
        end
      end

      translation.slug = parse_url_chars(slug)
    end
  end

  def parse_url_chars(str)
    out = str.downcase
    out = out.tr(' ', '-')

    out = URI.encode(out)
    out.gsub('%23', '#') # Restore hashtags
  end

  def slug_to_href(object)
    href = object.slug

    if !href.nil? && !link?(object.slug)
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

  def link?(href)
    href.start_with?('/') || href.start_with?('#') || href.start_with?('http')
  end
end
