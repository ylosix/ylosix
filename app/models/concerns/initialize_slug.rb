module InitializeSlug
  def existence_slug(slug)
    i = 1
    i += 1 while Link.where(slug: "#{slug}_#{i}").size > 0

    "#{slug}_#{i}"
  end

  def unique_slug(object, slug, locale, enabled)
    return slug if link?(slug)

    link = Link.find_by(slug: slug)
    if id.nil? && link
      slug = existence_slug(slug)
    else
      if link
        if link.class_name != object.class.name || link.object_id != object.id
          slug = existence_slug(slug)
        else
          link.update_attribute(:slug, slug)
          return slug
        end
      else
        Link.create(class_name: object.class.name,
                    object_id: object.id,
                    slug: slug,
                    locale: locale,
                    enabled: enabled)
      end
    end

    slug
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

  def save_slug(translations, field_translation, object)
    enabled = true
    enabled = object.enabled if object.respond_to?(:enabled)

    translations.each do |translation|
      slug = translation.slug
      unless slug
        slug = 'needs-to-be-changed'

        if field_translation
          if translation[field_translation]
            slug = translation[field_translation]
          elsif translations.any? && translations.first[field_translation]
            slug = translations.first[field_translation]
          end
        end
      end

      translation.slug = unique_slug(object, parse_url_chars(slug), translation.locale, enabled)
    end
  end
end
