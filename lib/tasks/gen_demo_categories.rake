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

    photo_attributes = {:parent_id => root.id,
                        category_translations_attributes: [{locale: :en, name: 'Photography', slug: PHOTOGRAPHY_SLUG},
                                                           {locale: :es, name: 'Fotografía', slug: PHOTOGRAPHY_SLUG}],
                        :enabled => true,
                        :visible => true}
    photography = Utils.create_or_update_model(Category, {reference_code: PHOTOGRAPHY_SLUG}, photo_attributes)

    phones_attributes = {:parent_id => root.id,
                         category_translations_attributes: [{locale: :en, name: 'Phones', slug: PHONES_SLUG},
                                                            {locale: :es, name: 'Teléfonos', slug: PHONES_SLUG}],
                         :enabled => true,
                         :visible => true}
    phones = Utils.create_or_update_model(Category, {:reference_code => PHONES_SLUG}, phones_attributes)


    video_attributes = {:parent_id => root.id,
                        category_translations_attributes: [{locale: :en, name: 'Video cameras', :slug => VIDEOS_SLUG},
                                                           {locale: :es, name: 'Vídeo cámaras', :slug => VIDEOS_SLUG}],
                        :enabled => true,
                        :visible => true}
    videos = Utils.create_or_update_model(Category, {:reference_code => VIDEOS_SLUG}, video_attributes)

    # Sub-categories
    reflex_attributes = {:parent_id => photography.id,
                         category_translations_attributes: [{locale: :en, name: 'Reflex', :slug => PHOTOGRAPHY_REFLEX_SLUG},
                                                            {locale: :es, name: 'Reflex', :slug => PHOTOGRAPHY_REFLEX_SLUG}],
                         :enabled => true,
                         :visible => true}
    Utils.create_or_update_model(Category, {:reference_code => PHOTOGRAPHY_REFLEX_SLUG}, reflex_attributes)

    lenses_attributes = {:parent_id => photography.id,
                         category_translations_attributes: [{locale: :en, name: 'Lenses', :slug => PHOTOGRAPHY_LENSES_SLUG},
                                                            {locale: :es, name: 'Objetivos', :slug => PHOTOGRAPHY_LENSES_SLUG}],
                         :enabled => true,
                         :visible => true}
    Utils.create_or_update_model(Category, {:reference_code => PHOTOGRAPHY_LENSES_SLUG}, lenses_attributes)

    accessories_attributes = {:parent_id => phones.id,
                              category_translations_attributes: [{locale: :en, name: 'Accessories', :slug => PHONES_ACCESSORIES_SLUG},
                                                                 {locale: :es, name: 'Accesorios', :slug => PHONES_ACCESSORIES_SLUG}],
                              :enabled => true,
                              :visible => true}
    Utils.create_or_update_model(Category, {:reference_code => PHONES_ACCESSORIES_SLUG}, accessories_attributes)

    phones_attributes = {:parent_id => phones.id,
                         category_translations_attributes: [{locale: :en, name: 'Smart-phones', :slug => PHONES_SMART_PHONES_SLUG},
                                                            {locale: :es, name: 'Smart-phones', :slug => PHONES_SMART_PHONES_SLUG}],
                         :enabled => true,
                         :visible => true}
    Utils.create_or_update_model(Category, {:reference_code => PHONES_SMART_PHONES_SLUG}, phones_attributes)

    accessories_attributes = {:parent_id => videos.id,
                              category_translations_attributes: [{locale: :en, name: 'Accessories', :slug => VIDEOS_ACCESSORIES_SLUG},
                                                                 {locale: :es, name: 'Accesorios', :slug => VIDEOS_ACCESSORIES_SLUG}],
                              :enabled => true,
                              :visible => true}
    Utils.create_or_update_model(Category, {:reference_code => VIDEOS_ACCESSORIES_SLUG}, accessories_attributes)

    cameras_attributes = {:parent_id => videos.id,
                          category_translations_attributes: [{:locale => :en, name: 'Cameras', :slug => VIDEOS_CAMERAS_SLUG},
                                                             {:locale => :es, name: 'Cámeras', :slug => VIDEOS_CAMERAS_SLUG}],
                          :enabled => true,
                          :visible => true}
    Utils.create_or_update_model(Category, {:reference_code => VIDEOS_CAMERAS_SLUG}, cameras_attributes)
  end
end