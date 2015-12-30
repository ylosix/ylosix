namespace :db do
  PHOTOGRAPHY_SLUG = 'photography'
  PHOTOGRAPHY_REFLEX_SLUG = 'photography-reflex'
  PHOTOGRAPHY_LENSES_SLUG = 'photography-lenses'

  PHONES_SLUG = 'phones'
  PHONES_SMART_PHONES_SLUG = 'phones-smart-phones'
  PHONES_ACCESSORIES_SLUG = 'phones-accessories'

  VIDEOS_SLUG = 'video'
  VIDEOS_CAMERAS_SLUG = 'video-cameras'
  VIDEOS_ACCESSORIES_SLUG = 'video-accessories'
  CAMERAS_SLUG = 'cameras'


  desc 'Generate demo commerce'
  task :gen_demo_categories => :environment do
    puts '####################'
    puts '## Creating categories'
    puts '####################'
    root = Category.find_by(reference_code: 'root')

    photo_attributes = {parent_id: root.id,
                        name_translations: {'en' => 'Photography', 'es' => 'Fotografía'},
                        slug_translations: {'en' => PHOTOGRAPHY_SLUG, 'es' => PHOTOGRAPHY_SLUG},
                        enabled: true,
                        visible: true}
    photography = Utils.create_or_update_model(Category, {reference_code: PHOTOGRAPHY_SLUG}, photo_attributes)

    phones_attributes = {parent_id: root.id,
                         name_translations: {'en' => 'Phones', 'es' => 'Teléfonos'},
                         slug_translations: {'en' => PHONES_SLUG, 'es' => PHONES_SLUG},
                         enabled: true,
                         visible: true}
    phones = Utils.create_or_update_model(Category, {reference_code: PHONES_SLUG}, phones_attributes)


    video_attributes = {parent_id: root.id,
                        name_translations: {'en' => 'Video cameras', 'es' => 'Vídeo cámaras'},
                        slug_translations: {'en' => VIDEOS_SLUG, 'es' => VIDEOS_SLUG},
                        enabled: true,
                        visible: true}
    videos = Utils.create_or_update_model(Category, {reference_code: VIDEOS_SLUG}, video_attributes)

    # Sub-categories
    reflex_attributes = {parent_id: photography.id,
                         name_translations: {'en' => 'Reflex', 'es' => 'Reflex'},
                         slug_translations: {'en' => PHOTOGRAPHY_REFLEX_SLUG, 'es' => PHOTOGRAPHY_REFLEX_SLUG},
                         enabled: true,
                         visible: true}
    Utils.create_or_update_model(Category, {reference_code: PHOTOGRAPHY_REFLEX_SLUG}, reflex_attributes)

    lenses_attributes = {parent_id: photography.id,
                         name_translations: {'en' => 'Lenses', 'es' => 'Objetivos'},
                         slug_translations: {'en' => PHOTOGRAPHY_LENSES_SLUG, 'es' => PHOTOGRAPHY_LENSES_SLUG},
                         enabled: true,
                         visible: true}
    Utils.create_or_update_model(Category, {reference_code: PHOTOGRAPHY_LENSES_SLUG}, lenses_attributes)

    accessories_attributes = {parent_id: phones.id,
                              name_translations: {'en' => 'Accessories', 'es' => 'Accesorios'},
                              slug_translations: {'en' => PHONES_ACCESSORIES_SLUG, 'es' => PHONES_ACCESSORIES_SLUG},
                              enabled: true,
                              visible: true}
    Utils.create_or_update_model(Category, {reference_code: PHONES_ACCESSORIES_SLUG}, accessories_attributes)

    phones_attributes = {parent_id: phones.id,
                         name_translations: {'en' => 'Smart-phones', 'es' => 'Smart-phones'},
                         slug_translations: {'en' => PHONES_SMART_PHONES_SLUG, 'es' => PHONES_SMART_PHONES_SLUG},
                         enabled: true,
                         visible: true}
    Utils.create_or_update_model(Category, {reference_code: PHONES_SMART_PHONES_SLUG}, phones_attributes)

    accessories_attributes = {parent_id: videos.id,
                              name_translations: {'en' => 'Accessories', 'es' => 'Accesorios'},
                              slug_translations: {'en' => VIDEOS_ACCESSORIES_SLUG, 'es' => VIDEOS_ACCESSORIES_SLUG},
                              enabled: true,
                              visible: true}
    Utils.create_or_update_model(Category, {reference_code: VIDEOS_ACCESSORIES_SLUG}, accessories_attributes)

    cameras_attributes = {parent_id: videos.id,
                          name_translations: {'en' => 'Cameras', 'es' => 'Cámaras'},
                          slug_translations: {'en' => CAMERAS_SLUG, 'es' => CAMERAS_SLUG},
                          enabled: true,
                          visible: true}
    Utils.create_or_update_model(Category, {reference_code: VIDEOS_CAMERAS_SLUG}, cameras_attributes)
  end
end