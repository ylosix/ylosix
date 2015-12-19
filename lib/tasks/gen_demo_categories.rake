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


  desc 'Generate demo commerce'
  task :gen_demo_categories => :environment do
    puts '####################'
    puts '## Creating categories'
    puts '####################'
    root = Category.find_by({:reference_code => 'root'})

    photo_attributes = {parent_id: root.id,
                        name: {en: 'Photography', es: 'Fotografía'},
                        slug: {en: PHOTOGRAPHY_SLUG, es: PHOTOGRAPHY_SLUG},
                        enabled: true,
                        visible: true}
    photography = Utils.create_or_update_model(Category, {reference_code: PHOTOGRAPHY_SLUG}, photo_attributes)

    phones_attributes = {parent_id: root.id,
                         name: {en: 'Phones', es: 'Teléfonos'},
                         slug: {en: PHONES_SLUG, es: PHONES_SLUG},
                         enabled: true,
                         visible: true}
    phones = Utils.create_or_update_model(Category, {reference_code: PHONES_SLUG}, phones_attributes)


    video_attributes = {parent_id: root.id,
                        name: {en: 'Video cameras', es: 'Vídeo cámaras'},
                        slug: {en: VIDEOS_SLUG, es: VIDEOS_SLUG},
                        enabled: true,
                        visible: true}
    videos = Utils.create_or_update_model(Category, {reference_code: VIDEOS_SLUG}, video_attributes)

    # Sub-categories
    reflex_attributes = {parent_id: photography.id,
                         name: {en: 'Reflex', es: 'Reflex'},
                         slug: {en: PHOTOGRAPHY_REFLEX_SLUG, es: PHOTOGRAPHY_REFLEX_SLUG},
                         enabled: true,
                         visible: true}
    Utils.create_or_update_model(Category, {reference_code: PHOTOGRAPHY_REFLEX_SLUG}, reflex_attributes)

    lenses_attributes = {parent_id: photography.id,
                         name: {en: 'Lenses', es: 'Objetivos'},
                         slug: {en: PHOTOGRAPHY_LENSES_SLUG, es: PHOTOGRAPHY_LENSES_SLUG},
                         enabled: true,
                         visible: true}
    Utils.create_or_update_model(Category, {reference_code: PHOTOGRAPHY_LENSES_SLUG}, lenses_attributes)

    accessories_attributes = {parent_id: phones.id,
                              name: {en: 'Accessories', es: 'Accesorios'},
                              slug: {en: PHONES_ACCESSORIES_SLUG, es: PHONES_ACCESSORIES_SLUG},
                              enabled: true,
                              visible: true}
    Utils.create_or_update_model(Category, {reference_code: PHONES_ACCESSORIES_SLUG}, accessories_attributes)

    phones_attributes = {parent_id: phones.id,
                         name: {en: 'Smart-phones', es: 'Smart-phones'},
                         slug: {en: PHONES_SMART_PHONES_SLUG, es: PHONES_SMART_PHONES_SLUG},
                         enabled: true,
                         visible: true}
    Utils.create_or_update_model(Category, {reference_code: PHONES_SMART_PHONES_SLUG}, phones_attributes)

    accessories_attributes = {parent_id: videos.id,
                              name: {en: 'Accessories', es: 'Accesorios'},
                              slug: {en: VIDEOS_ACCESSORIES_SLUG, es: VIDEOS_ACCESSORIES_SLUG},
                              enabled: true,
                              visible: true}
    Utils.create_or_update_model(Category, {reference_code: VIDEOS_ACCESSORIES_SLUG}, accessories_attributes)

    cameras_attributes = {parent_id: videos.id,
                          name: {en: 'Cameras', es: 'Cámaras'},
                          enabled: true,
                          visible: true}
    Utils.create_or_update_model(Category, {reference_code: VIDEOS_CAMERAS_SLUG}, cameras_attributes)
  end
end