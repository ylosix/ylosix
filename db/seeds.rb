# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def save_or_update_model(model, search_options, attributes)
  object = model.find_or_create_by(search_options)
  object.attributes = attributes
  object.save

  object
end

def create_default_admin_user
  puts '####################'
  puts '## Creating default admin user'
  puts '####################'

  admin = AdminUser.find_by(:email => 'admin@example.com')
  if admin.nil?
    AdminUser.create!(:email => 'admin@example.com',
                      :password => 'password',
                      :password_confirmation => 'password')
  end
end

def create_default_languages
  puts '####################'
  puts '## Creating default languages'
  puts '####################'

  available_locales = %w(en es)
  available_locales.each do |locale|
    name = 'English'
    name = 'Español' if locale == 'es'

    flag_file = File.new "#{Rails.root}/app/assets/images/flags/#{locale}.png"
    language_attributes = {:locale => locale,
                           :name => name,
                           :flag => flag_file,
                           :appears_in_backoffice => true,
                           :appears_in_web => true}

    save_or_update_model(Language, {:locale => locale}, language_attributes)
  end
end

def create_default_taxes
  puts '####################'
  puts '## Creating default taxes'
  puts '####################'

  iva_es_attributes = { :name => 'IVA ES 21%', :rate => 21.0 }
  save_or_update_model(Tax, { :name => 'IVA ES 21%' }, iva_es_attributes)
end


def create_product(product_attributes, categories, tags)
  product = save_or_update_model(Product,
                                 { reference_code: product_attributes[:reference_code] },
                                 product_attributes)

  product.categories = categories
  product.tags = tags
  product.save
end

def create_default_products
  puts '####################'
  puts '## Creating products'
  puts '####################'

  category = Category.find_by_slug('digital_cameras')
  categories = [category]

  tag_cameras = Tag.with_translations.find_by(:tag_translations => {:name => 'Cameras', :locale => :en })
  tag_reflex = Tag.with_translations.find_by(:tag_translations => {:name => 'Reflex', :locale => :en })
  tags = [tag_cameras, tag_reflex]

  tax_iva = Tax.find_by({ :name => 'IVA ES 21%' })

  camera_image = File.new "#{Rails.root}/app/assets/images/products/canon_450d.png"
  product_attributes = {:reference_code => 'ref1',
                        :name => 'Canon 450D',
                        :locale => :en,
                        :barcode => '123456789',
                        :enabled => true,
                        :appears_in_categories => true,
                        :appears_in_tag => true,
                        :appears_in_search => true,
                        :short_description => 'Camera reflex canon 12MP.',
                        :description => 'Camera reflex canon 12 MP (not includes SD).',

                        :retail_price_pre_tax => 350.0,
                        :retail_price => 423.5,
                        :tax => tax_iva,

                        :meta_keywords => 'canon_450d',
                        :meta_description => 'Camera reflex canon',
                        :slug => 'canon_450d',
                        :stock => 100,
                        :control_stock => true,
                        :image => camera_image}

  create_product(product_attributes, categories, tags)

  camera_image = File.new "#{Rails.root}/app/assets/images/products/nikon_d5500.png"
  product_attributes = {:reference_code => 'ref2',
                        :name => 'Nikon D5500',
                        :locale => :en,
                        :barcode => '1234567890',
                        :enabled => true,
                        :appears_in_categories => true,
                        :appears_in_tag => true,
                        :appears_in_search => true,
                        :short_description => 'Camera reflex Nikon 24MP.',
                        :description => 'Camera reflex Nikon 24 MP (not includes SD).',

                        :retail_price_pre_tax => 350.0,
                        :retail_price => 423.5,
                        :tax => tax_iva,

                        :meta_keywords => 'nikon_D5500',
                        :meta_description => 'Camera reflex nikon',
                        :slug => 'nikon_d5500',
                        :stock => 100,
                        :control_stock => true,
                        :image => camera_image}

  create_product(product_attributes, categories, tags)


  zoom_image = File.new "#{Rails.root}/app/assets/images/products/DX-Zoom-10-24mm.png"
  product_attributes = {:reference_code => 'ref3',
                        :name => 'AF-S DX 10-24mm',
                        :locale => :en,
                        :barcode => '1234567891',
                        :enabled => true,
                        :appears_in_categories => true,
                        :appears_in_tag => true,
                        :appears_in_search => true,
                        :short_description => 'AF-S DX Zoom-NIKKOR 10-24mm f/3.5-4.5G ED.',
                        :description => 'AF-S DX Zoom-NIKKOR 10-24mm f/3.5-4.5G ED.',

                        :retail_price_pre_tax => 350.0,
                        :retail_price => 423.5,
                        :tax => tax_iva,

                        :meta_keywords => 'dx_zoom_10-24mm',
                        :meta_description => 'Zoom reflex nikon',
                        :slug => 'zoom-nikkor-10-24mm',
                        :stock => 100,
                        :control_stock => true,
                        :image => zoom_image}

  category = Category.find_by_slug('lenses')
  categories = [category]
  create_product(product_attributes, categories, tags)
end

def create_default_categories
  puts '####################'
  puts '## Creating categories'
  puts '####################'

  root_attributes = {:parent_id => nil,
                     :name => 'root',
                     :locale => :en,
                     :enabled => true,
                     :appears_in_web => true,
                     :slug => 'root'}
  root = save_or_update_model(Category, {:slug => 'root'}, root_attributes)

  category_cam_attributes = {:parent_id => root.id,
                             :name => 'Digital Cameras',
                             :locale => :en,
                             :enabled => true,
                             :appears_in_web => true,
                             :slug => 'digital_cameras'}
  digital_cameras = save_or_update_model(Category, {:slug => 'digital_cameras'}, category_cam_attributes)

  category_cam_attributes = {:parent_id => digital_cameras.id,
                             :name => 'Lenses',
                             :locale => :en,
                             :enabled => true,
                             :appears_in_web => true,
                             :slug => 'lenses'}
  save_or_update_model(Category, {:slug => 'lenses'}, category_cam_attributes)
end


def create_default_tags
  puts '####################'
  puts '## Creating tags'
  puts '####################'

  tag_cameras_attributes = {:parent_id => nil,
                            :name => 'Cameras',
                            :locale => :en,
                            :appears_in_web => true}
  tag_cameras = Tag.with_translations.find_by(:tag_translations => {:name => 'Cameras', :locale => :en })
  if tag_cameras.nil?
    tag_cameras = Tag.create!(tag_cameras_attributes)
  end

  tag_reflex_attributes = {:parent_id => tag_cameras.id,
                           :name => 'Reflex',
                           :locale => :en,
                           :appears_in_web => true}
  tag_reflex = Tag.with_translations.find_by(:tag_translations => {:name => 'Reflex', :locale => :en })
  if tag_reflex.nil?
    Tag.create!(tag_reflex_attributes)
  end
end


def create_default_ylos_template
  puts '####################'
  puts '## Creating ylos template'
  puts '####################'

  ylos_template = {:name => 'ylos',
                   :path => '/public/templates/ylos',
                   :enabled => false}
  save_or_update_model(Template, {:name => 'ylos'}, ylos_template)
end


def create_defaults
  create_default_languages
  create_default_admin_user
  create_default_categories
  create_default_tags
  create_default_taxes
  create_default_products
  create_default_ylos_template
end

create_defaults