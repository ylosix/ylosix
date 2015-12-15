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

      translation.slug = unique_slug(parse_url_chars(slug), translation)
    end
  end

  def unique_slug(slug, translation, check_models = [Category, Product, Tag])
    return slug if link?(slug)

    if check_models.empty?
      count = self.class.with_translations.where('slug like :slug', slug: slug).uniq(self.class).length
    else
      count = 0
      check_models.each do |model|
        count += model.with_translations.where('slug like :slug', slug: slug).uniq(model).length
      end
    end

    # slug not changed
    count -= 1 if !translation.id.blank? && translation.slug == slug
    slug + (count > 0 ? "_#{count}" : '')
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
      if object.class == Category
        href = Routes.category_path(object.slug)
      elsif object.class == Product
        href = Routes.product_path(object.slug)
        if object.categories.any?
          href = Routes.category_show_product_slug_path(object.categories.first.slug, object.slug)
        end
      end
    end

    href
  end

  def link?(href)
    href.start_with?('/') || href.start_with?('#') || href.start_with?('http')
  end
end
