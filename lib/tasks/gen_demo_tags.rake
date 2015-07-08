namespace :db do
  desc 'Generate demo tags'
  task :gen_demo_tags => :environment do
    puts '####################'
    puts '## Creating tags'
    puts '####################'

    general_tags_group_attributes = {:name => 'General', :locale => :en}
    general_tags_group_attributes_all = general_tags_group_attributes.clone
    general_tags_group = Utils.create_model_translations(TagsGroup,
                                                         :tags_group_translations,
                                                         general_tags_group_attributes,
                                                         general_tags_group_attributes_all)
    general_tags_group.tags_group_translations << TagsGroupTranslation.new({locale: :es, name: 'General'})
    general_tags_group.save

    tag_cameras_attributes = {:name => 'Lenses', :locale => :en}
    tag_cameras_attributes_all = tag_cameras_attributes.clone
    tag_cameras_attributes_all[:slug] = 'lenses'
    tag_cameras = Utils.create_model_translations(Tag,
                                                  :tag_translations,
                                                  tag_cameras_attributes,
                                                  tag_cameras_attributes_all)
    tag_cameras.update_attributes(tags_group_id: general_tags_group.id)
    tag_cameras.tag_translations << TagTranslation.new({locale: :es, name: 'Objetivos'})
    tag_cameras.save

    tag_reflex_attributes = {:name => 'Reflex', :locale => :en}
    tag_reflex_attributes_all = tag_reflex_attributes.clone
    tag_reflex_attributes_all[:slug] = 'reflex'
    tag_reflex = Utils.create_model_translations(Tag,
                                                 :tag_translations,
                                                 tag_reflex_attributes,
                                                 tag_reflex_attributes_all)
    tag_reflex.update_attributes(tags_group_id: general_tags_group.id)
    tag_reflex.tag_translations << TagTranslation.new({locale: :es, name: 'Reflex'})
    tag_reflex.save

    tag_smart_phones_attributes = {:name => 'Smart-phones', :locale => :en}
    tag_smart_phones_attributes_all = tag_smart_phones_attributes.clone
    tag_smart_phones_attributes_all[:slug] = 'smart-phones'
    tag_smart_phones = Utils.create_model_translations(Tag,
                                                 :tag_translations,
                                                 tag_reflex_attributes,
                                                 tag_reflex_attributes_all)
    tag_smart_phones.update_attributes(tags_group_id: general_tags_group.id)
    tag_smart_phones.tag_translations << TagTranslation.new({locale: :es, name: 'Smart-phones'})
    tag_smart_phones.save
  end
end