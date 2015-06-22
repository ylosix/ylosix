module InitializableSlug
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
    out = str
    out = out.gsub('.', '-')
    out = out.gsub(' ', '-')

    URI.encode(out)
  end
end
