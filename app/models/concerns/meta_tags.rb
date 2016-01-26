module MetaTags
  def meta_tags_hash
    return {} if meta_tags.blank?

    begin
      return JSON.parse(meta_tags.to_s.gsub('=>', ':'))
    rescue
      return {}
    end
  end
end
