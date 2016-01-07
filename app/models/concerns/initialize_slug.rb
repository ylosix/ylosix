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
          link.update_attribute(:enabled, enabled)
          link.update_attribute(:href, href)
          return slug
        end
      end

      attributes = {class_name: object.class.name,
                    object_id: object.id,
                    slug: slug,
                    href: href,
                    locale: locale,
                    enabled: enabled}

      link = Link.find_by(class_name: object.class.name, object_id: object.id, locale: locale)
      if link
        link.update_attributes(attributes)
      else
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

  def slug_to_href(object, locale)
    if locale.nil?
      href = object.slug
    else
      href = object.slug_translations[locale]
    end
    slug = href

    if !href.nil? && !link?(slug)
      if object.class == Category
        slugs = Utils.get_parents_array(object).map(&:slug_translations).map { |x| x[locale] }

        slugs << slug
        slugs.delete_at(0) if slugs.size > 1
        slugs = slugs.delete_if { |i| link?(i) }

        href = Routes.dynamic_path_path(slugs)
      elsif object.class == Product
        if object.categories.any?
          categories = object.categories.sort do |x, y|
            begin
              Utils.get_parents_array(y).size <=> Utils.get_parents_array(x).size
            rescue ClassErrors::ParentLoopError
            end
          end

          slugs = Utils.get_parents_array(categories.first)
          slugs << categories.first
          slugs = slugs.map(&:slug_translations).map { |x| x[locale] }

          slugs << object.slug_translations[locale]
          slugs.delete_at(0) if slugs.size > 1
          slugs = slugs.delete_if { |i| link?(i) }

          href = Routes.dynamic_path_path(slugs)
        else
          href = Routes.product_path(slug)
        end

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

  def save_slug(field_translation, object)
    enabled = true
    enabled = object.enabled if object.respond_to?(:enabled)

    Language.in_backoffice.each do |language|
      locale_sym = language.locale.to_sym
      slug = object[:slug_translations][language.locale]
      slug ||= object[:slug_translations][locale_sym]

      if slug.blank?
        if field_translation && object[field_translation]
          slug = object[field_translation][language.locale]
          slug ||= object[field_translation][locale_sym]
        end
      end

      slug ||= 'needs-to-be-changed'

      object[:slug_translations][language.locale] = unique_slug(object, parse_url_chars(slug), language.locale, enabled)
      object.update_column(:slug_translations, object[:slug_translations])

      object[:href_translations][language.locale] = slug_to_href(object, language.locale)
      object.update_column(:href_translations, object[:href_translations])
    end
  end
end
