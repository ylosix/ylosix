# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

PHOTOGRAPHY_SLUG = 'photography'
PHOTOGRAPHY_REFLEX_SLUG = 'photography-reflex'
PHOTOGRAPHY_LENSES_SLUG = 'photography-lenses'

PHONES_SLUG = 'phones'
PHONES_SMART_PHONES_SLUG = 'phones-smart-phones'
PHONES_ACCESSORIES_SLUG = 'phones-accessories'

def save_or_update_model(model, search_options, attributes)
  object = model.find_or_create_by(search_options)
  object.attributes = attributes
  object.save

  object
end

def create_address(attributes = {})
  saddress = CustomerAddress.new(attributes)

  unless saddress.customer.nil?
    saddress.customer_name = saddress.customer.name
    saddress.customer_last_name = saddress.customer.last_name
  end

  saddress.address_1 = 'Rambla Nova, 72'
  saddress.postal_code = '43002'
  saddress.city = 'Tarragona'
  saddress.country = 'Spain'
  saddress.phone = '977112233'
  saddress.mobile_phone = '616112233'
  saddress.dni = '123456789T'

  saddress.save
end

def create_default_admin_user
  puts '####################'
  puts '## Creating default admin user'
  puts '####################'

  admin = AdminUser.find_by(:email => 'admin@ylosix.com')
  if admin.nil?
    AdminUser.create!(:email => 'admin@ylosix.com',
                      :password => 'password',
                      :password_confirmation => 'password')
  end

  puts '####################'
  puts '## Creating default user'
  puts '####################'

  customer = Customer.find_by(:email => 'customer@ylosix.com')
  if customer.nil?
    customer = Customer.create!(:email => 'customer@ylosix.com',
                                :name => 'Ylos',
                                :last_name => 'Hispania',
                                :birth_date => DateTime.now,
                                :password => 'password',
                                :locale => 'en',
                                :password_confirmation => 'password')
  end

  if customer.customer_addresses.empty?
    create_address({name: 'My billing address',
                    customer: customer,
                    default_billing: true,
                    default_shipping: false})
    create_address({name: 'My shipping address',
                    customer: customer,
                    default_billing: false,
                    default_shipping: true})
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

  iva_es_attributes = {:name => 'IVA ES 21%', :rate => 21.0}
  save_or_update_model(Tax, {:name => 'IVA ES 21%'}, iva_es_attributes)
end


def create_product(product_attributes, categories, tags)
  product = save_or_update_model(Product,
                                 {reference_code: product_attributes[:reference_code]},
                                 product_attributes)

  product.categories = categories
  product.tags = tags
  product.save
end

def create_default_products
  puts '####################'
  puts '## Creating products'
  puts '####################'

  category = Category.find_by_slug(PHOTOGRAPHY_REFLEX_SLUG)
  categories = [category]

  tag_cameras = Tag.with_translations.find_by(:tag_translations => {:name => 'Cameras', :locale => :en})
  tag_reflex = Tag.with_translations.find_by(:tag_translations => {:name => 'Reflex', :locale => :en})
  tags = [tag_cameras, tag_reflex]

  tax_iva = Tax.find_by({:name => 'IVA ES 21%'})

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

  category = Category.find_by_slug(PHOTOGRAPHY_LENSES_SLUG)
  categories = [category]
  create_product(product_attributes, categories, tags)

  category = Category.find_by_slug(PHONES_SMART_PHONES_SLUG)
  categories = [category]

  tax_iva = Tax.find_by({:name => 'IVA ES 21%'})

  camera_image = File.new "#{Rails.root}/app/assets/images/products/Huawei-Ascend-G630.png"
  product_attributes = {:reference_code => 'ref4',
                        :name => 'Huawei Ascend G630 white 5" HD & 8MP',
                        :locale => :en,
                        :barcode => '12321321312',
                        :enabled => true,
                        :appears_in_categories => true,
                        :appears_in_tag => true,
                        :appears_in_search => true,
                        :short_description => 'Sé el más de la clase (aunque ya ni vayas) y hazte ya con el móvil Huawei Ascend G630, que te dará todo lo que buscas en un smartphone, pero con el precio que aún no encontrabas..',
                        :description => '<p>Sé el más de la clase (aunque ya ni vayas) y hazte ya con el móvil Huawei Ascend G630, que te dará todo lo que buscas en un smartphone, pero con el precio que aún no encontrabas.</p>
<p>Tu querías una pantalla grande y él te ofrece 5 pulgadas de resolución HD con tecnología IPS, para que disfrutes de todo tu mundo a lo grande y con gran calidad de detalle.</p>
<p>Buscabas una cámara con buena resolución y Huawei pone a tu servicio 8 Megapíxeles con enfoque automático y otra cámara frontal de 1 Mpx. para que puedas hacer vídeollamadas y retratos con total cómodidad.</p>
<p>Ansiabas velocidad y con el G630 la tendrás gracias a su potente procesador Quad Core, que sumado a la memoria RAM de 1GB da un resultado multi-tarea increíble.</p>
<p>Además tendrás a tu disposición todo tipo de conexiones para compartir tu mundo, como el NFC, Bluetooth, WiFi y el mejor sonido DTS.</p>
<p>Como te decía... Huawei Ascend G630 tiene todo lo que buscas, ¡incluido el precio!</p>',

                        :retail_price_pre_tax => 100.0,
                        :retail_price => 121.0,
                        :tax => tax_iva,

                        :meta_keywords => 'huawei',
                        :meta_description => 'huawei smartphone',
                        :slug => 'huawei-ascend-g630',
                        :stock => 100,
                        :control_stock => true,
                        :image => camera_image}

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

  photo_attributes = {:parent_id => root.id,
                      :name => 'Photography',
                      :locale => :en,
                      :enabled => true,
                      :appears_in_web => true,
                      :slug => PHOTOGRAPHY_SLUG}
  photography = save_or_update_model(Category, {:slug => PHOTOGRAPHY_SLUG}, photo_attributes)

  phones_attributes = {:parent_id => root.id,
                             :name => 'Phones',
                             :locale => :en,
                             :enabled => true,
                             :appears_in_web => true,
                             :slug => PHONES_SLUG}
  phones = save_or_update_model(Category, {:slug => PHONES_SLUG}, phones_attributes)


  video_attributes = {:parent_id => root.id,
                      :name => 'Video',
                      :locale => :en,
                      :enabled => true,
                      :appears_in_web => true,
                      :slug => 'video'}
  save_or_update_model(Category, {:slug => 'video'}, video_attributes)

  # Sub-categories
  reflex_attributes = {:parent_id => photography.id,
                       :name => 'Reflex',
                       :locale => :en,
                       :enabled => true,
                       :appears_in_web => true,
                       :slug => PHOTOGRAPHY_REFLEX_SLUG}
  save_or_update_model(Category, {:slug => PHOTOGRAPHY_REFLEX_SLUG}, reflex_attributes)

  lenses_attributes = {:parent_id => photography.id,
                       :name => 'Lenses',
                       :locale => :en,
                       :enabled => true,
                       :appears_in_web => true,
                       :slug => PHOTOGRAPHY_LENSES_SLUG}
  save_or_update_model(Category, {:slug => PHOTOGRAPHY_LENSES_SLUG}, lenses_attributes)

  accessories_attributes = {:parent_id => phones.id,
                            :name => 'Accessories',
                            :locale => :en,
                            :enabled => true,
                            :appears_in_web => true,
                            :slug => PHONES_ACCESSORIES_SLUG}
  save_or_update_model(Category, {:slug => PHONES_ACCESSORIES_SLUG}, accessories_attributes)

  phones_attributes = {:parent_id => phones.id,
                       :name => 'Smart phones',
                       :locale => :en,
                       :enabled => true,
                       :appears_in_web => true,
                       :slug => PHONES_SMART_PHONES_SLUG}
  save_or_update_model(Category, {:slug => PHONES_SMART_PHONES_SLUG}, phones_attributes)
end


def create_default_tags
  puts '####################'
  puts '## Creating tags'
  puts '####################'

  tag_cameras_attributes = {:parent_id => nil,
                            :name => 'Cameras',
                            :locale => :en,
                            :appears_in_web => true}
  tag_cameras = Tag.with_translations.find_by(:tag_translations => {:name => 'Cameras', :locale => :en})
  if tag_cameras.nil?
    tag_cameras = Tag.create!(tag_cameras_attributes)
  end

  tag_reflex_attributes = {:parent_id => tag_cameras.id,
                           :name => 'Reflex',
                           :locale => :en,
                           :appears_in_web => true}
  tag_reflex = Tag.with_translations.find_by(:tag_translations => {:name => 'Reflex', :locale => :en})
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


def create_default_shopping_cart
  puts '####################'
  puts '## Creating shopping carts'
  puts '####################'

  customer = Customer.find_by(email: 'customer@ylosix.com')
  sc = ShoppingCart.new(customer: customer)

  products = Product.where(enabled: true)

  sc.add_product(products[0])
  sc.add_product(products[1])

  sc.save
end


def create_default_orders
  puts '####################'
  puts '## Creating shopping orders'
  puts '####################'

  customer = Customer.find_by(email: 'customer@ylosix.com')
  sc = customer.shopping_cart
  sop = ShoppingOrder.new(customer: customer)

  sc.shopping_carts_products.each do |scp|
    sop.shopping_orders_products << scp.to_shopping_order
  end

  soa = ShoppingOrdersAddress.new
  soa.billing = true
  soa.shipping = true
  soa.fields = customer.customer_addresses.first.fields

  sop.shopping_orders_addresses << soa
  sop.save
end


def create_default_commerce
  puts '####################'
  puts '## Creating commerce'
  puts '####################'

  logo_image = File.new "#{Rails.root}/app/assets/images/ylos-logo.png"
  commerce_attributes = {default: true,
                         http: 'localhost',
                         logo: logo_image,
                         name: 'Demo ylosix'}
  save_or_update_model(Commerce, {name: 'Demo ylosix'}, commerce_attributes)
end


def create_defaults
  create_default_languages
  create_default_admin_user
  create_default_categories
  create_default_tags
  create_default_taxes
  create_default_products
  create_default_shopping_cart
  create_default_orders
  create_default_ylos_template
  create_default_commerce
end

create_defaults