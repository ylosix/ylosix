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
      href = slug_to_href(object, locale)

      if link
        if link.class_name != object.class.name || link.object_id != object.id
          slug = existence_slug(slug)
        else
          link.update_attribute(:slug, slug)
          link.update_attribute(:href, href) if Link.respond_to?(:href)
          return slug
        end
      else
        attributes = {class_name: object.class.name,
                      object_id: object.id,
                      slug: slug,
                      locale: locale,
                      enabled: enabled}

        attributes[:href] = href if Link.respond_to?(:href)

        Link.create(attributes)
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

  def slug_to_href(object, locale = nil)
    if locale.nil?
      href = object.slug
    else
      href = object.slug_translations[locale]
    end
    slug = href

    if !href.nil? && !link?(slug)
      if object.class == Category
        href = Routes.category_path(slug)
      elsif object.class == Product
        href = Routes.product_path(slug)
        # TODO, refactor this
        # if object.categories.any?
        #   href = Routes.category_show_product_slug_path(object.categories.first.slug, slug)
        # end
      end
    end

    href
  end

  def link?(href)
    !href.nil? && (href.start_with?('/') || href.start_with?('#') || href.start_with?('http'))
  end

  def save_slug(_translations, field_translation, object)
    enabled = true
    enabled = object.enabled if object.respond_to?(:enabled)

    Language.in_backoffice.each do |language|
      locale_sym = language.locale.to_sym
      slug = object[:slug_translations][locale_sym]

      unless slug
        if field_translation && object[field_translation]
          slug = object[field_translation][locale_sym]
        end

        slug ||= 'needs-to-be-changed'
      end

      object[:slug_translations][locale_sym] = unique_slug(object, parse_url_chars(slug), language.locale, enabled)
      object.update_column(:slug_translations, object[:slug_translations])

      if object.respond_to?(:href_translations)
        object[:href_translations][locale_sym] = slug_to_href(object, language.locale)
        object.update_column(:href_translations, object[:href_translations])
      end
    end
  end
end
