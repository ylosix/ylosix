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

    root_attributes = {:parent_id => nil,
                       category_translations_attributes: [{:locale => :en, name: 'Root'},
                                                          {:locale => :es, name: 'Inicio'}],
                       :enabled => true,
                       :visible => true,
                       :slug => 'root'}
    root = Utils.create_or_update_model(Category, {:slug => 'root'}, root_attributes)

    photo_attributes = {:parent_id => root.id,
                        category_translations_attributes: [{:locale => :en, name: 'Photography'},
                                                           {:locale => :es, name: 'Fotografía'}],
                        :enabled => true,
                        :visible => true,
                        :slug => PHOTOGRAPHY_SLUG}
    photography = Utils.create_or_update_model(Category, {:slug => PHOTOGRAPHY_SLUG}, photo_attributes)

    phones_attributes = {:parent_id => root.id,
                         category_translations_attributes: [{:locale => :en, name: 'Phones'},
                                                            {:locale => :es, name: 'Teléfonos'}],
                         :enabled => true,
                         :visible => true,
                         :slug => PHONES_SLUG}
    phones = Utils.create_or_update_model(Category, {:slug => PHONES_SLUG}, phones_attributes)


    video_attributes = {:parent_id => root.id,
                        category_translations_attributes: [{:locale => :en, name: 'Video cameras', },
                                                           {:locale => :es, name: 'Vídeo cámaras'}],
                        :enabled => true,
                        :visible => true,
                        :slug => VIDEOS_SLUG}
    videos = Utils.create_or_update_model(Category, {:slug => VIDEOS_SLUG}, video_attributes)

    # Sub-categories
    reflex_attributes = {:parent_id => photography.id,
                         category_translations_attributes: [{:locale => :en, name: 'Reflex', },
                                                            {:locale => :es, name: 'Reflex'}],
                         :enabled => true,
                         :visible => true,
                         :slug => PHOTOGRAPHY_REFLEX_SLUG}
    Utils.create_or_update_model(Category, {:slug => PHOTOGRAPHY_REFLEX_SLUG}, reflex_attributes)

    lenses_attributes = {:parent_id => photography.id,
                         category_translations_attributes: [{:locale => :en, name: 'Lenses', },
                                                            {:locale => :es, name: 'Objetivos'}],
                         :enabled => true,
                         :visible => true,
                         :slug => PHOTOGRAPHY_LENSES_SLUG}
    Utils.create_or_update_model(Category, {:slug => PHOTOGRAPHY_LENSES_SLUG}, lenses_attributes)

    accessories_attributes = {:parent_id => phones.id,
                              category_translations_attributes: [{:locale => :en, name: 'Accessories', },
                                                                 {:locale => :es, name: 'Accesorios'}],
                              :enabled => true,
                              :visible => true,
                              :slug => PHONES_ACCESSORIES_SLUG}
    Utils.create_or_update_model(Category, {:slug => PHONES_ACCESSORIES_SLUG}, accessories_attributes)

    phones_attributes = {:parent_id => phones.id,
                         category_translations_attributes: [{:locale => :en, name: 'Smart-phones', },
                                                            {:locale => :es, name: 'Smart-phones'}],
                         :enabled => true,
                         :visible => true,
                         :slug => PHONES_SMART_PHONES_SLUG}
    Utils.create_or_update_model(Category, {:slug => PHONES_SMART_PHONES_SLUG}, phones_attributes)

    accessories_attributes = {:parent_id => videos.id,
                              category_translations_attributes: [{:locale => :en, name: 'Accessories', },
                                                                 {:locale => :es, name: 'Accesorios'}],
                              :enabled => true,
                              :visible => true,
                              :slug => VIDEOS_ACCESSORIES_SLUG}
    Utils.create_or_update_model(Category, {:slug => VIDEOS_ACCESSORIES_SLUG}, accessories_attributes)

    cameras_attributes = {:parent_id => videos.id,
                         category_translations_attributes: [{:locale => :en, name: 'Cameras', },
                                                            {:locale => :es, name: 'Cámeras'}],
                         :enabled => true,
                         :visible => true,
                         :slug => VIDEOS_CAMERAS_SLUG}
    Utils.create_or_update_model(Category, {:slug => VIDEOS_CAMERAS_SLUG}, cameras_attributes)
  end
end