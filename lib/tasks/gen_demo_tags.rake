namespace :db do
  desc 'Generate demo tags'
  task :gen_demo_tags => :environment do
    puts '####################'
    puts '## Creating tags'
    puts '####################'

    general_tags_group_attributes = {name_translations: {en: 'General', es: 'General'}}
    general_tags_group = Utils.create_model_translations(TagsGroup,
                                                         general_tags_group_attributes,
                                                         general_tags_group_attributes)
    general_tags_group.save

    tag_cameras_attributes = {name_translations: {en: 'Lenses', es: 'Objetivos'},
                              slug_translations: {en: 'lenses', es: 'objetivos'}}
    tag_cameras = Utils.create_model_translations(Tag,
                                                  tag_cameras_attributes,
                                                  tag_cameras_attributes)
    tag_cameras.update_attributes(tags_group_id: general_tags_group.id)
    tag_cameras.save

    tag_reflex_attributes = {name_translations: {en: 'Reflex', es: 'Reflex'},
                             slug_translations: {en: 'reflex', es: 'reflex'}}
    tag_reflex = Utils.create_model_translations(Tag,
                                                 tag_reflex_attributes,
                                                 tag_reflex_attributes)
    tag_reflex.update_attributes(tags_group_id: general_tags_group.id)
    tag_reflex.save

    tag_smart_phones_attributes = {name_translations: {en: 'Smart-phones', es: 'Smart-phones'},
                                   slug_translations: {en: 'smart-phones', es: 'smart-phones'}}
    tag_smart_phones = Utils.create_model_translations(Tag,
                                                       tag_smart_phones_attributes,
                                                       tag_smart_phones_attributes)
    tag_smart_phones.update_attributes(tags_group_id: general_tags_group.id)
    tag_smart_phones.save
  end
end