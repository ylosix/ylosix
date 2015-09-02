namespace :db do
  desc 'Generate demo tags'
  task :gen_demo_tags => :environment do
    puts '####################'
    puts '## Creating tags'
    puts '####################'

    general_tags_group_attributes = {:name => 'General', :locale => :en}
    general_tags_group = Utils.create_model_translations(TagsGroup,
                                                         :tags_group_translations,
                                                         general_tags_group_attributes)
    general_tags_group.tags_group_translations << TagsGroupTranslation.new({locale: :es, name: 'General'})
    general_tags_group.save

    tag_cameras_attributes = {:name => 'Lenses', :locale => :en, :slug => 'lenses'}
    tag_cameras = Utils.create_model_translations(Tag,
                                                  :tag_translations,
                                                  tag_cameras_attributes)
    tag_cameras.update_attributes(tags_group_id: general_tags_group.id)
    tag_cameras.tag_translations << TagTranslation.new({locale: :es, name: 'Objetivos', :slug => 'objetivos'})
    tag_cameras.save

    tag_reflex_attributes = {:name => 'Reflex', :locale => :en, :slug => 'reflex'}
    tag_reflex = Utils.create_model_translations(Tag,
                                                 :tag_translations,
                                                 tag_reflex_attributes)
    tag_reflex.update_attributes(tags_group_id: general_tags_group.id)
    tag_reflex.tag_translations << TagTranslation.new({locale: :es, name: 'Reflex', :slug => 'reflex'})
    tag_reflex.save

    tag_smart_phones_attributes = {:name => 'Smart-phones', :locale => :en, :slug => 'smart-phones'}
    tag_smart_phones = Utils.create_model_translations(Tag,
                                                       :tag_translations,
                                                       tag_smart_phones_attributes)
    tag_smart_phones.update_attributes(tags_group_id: general_tags_group.id)
    tag_smart_phones.tag_translations << TagTranslation.new({locale: :es, name: 'Smart-phones', :slug => 'smart-phones'})
    tag_smart_phones.save
  end
end