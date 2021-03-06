namespace :db do
  def create_product(product_attributes, categories, tags)
    product = Utils.create_or_update_model(Product,
                                           {reference_code: product_attributes[:reference_code]},
                                           product_attributes)

    product.categories = categories
    product.tags = tags
    product.save
  end

  def create_photograpy_products
    category = Category.find_by(reference_code: PHOTOGRAPHY_REFLEX_SLUG)
    categories = [category]

    tag_reflex = Tag.find_by('lower(tags.name_translations->?) LIKE lower(?)', 'en', '%Reflex%')
    tags = [tag_reflex]

    tax_iva = Tax.find_by(name: 'IVA ES 21%')

    camera_image = File.new "#{Rails.root}/app/assets/images/products/canon_450d.png"
    product_attributes = {reference_code: 'ref1',
                          meta_tags_translations: {en: {keywords: 'canon_450d', description: 'Camera reflex canon'},
                                                   es: {keywords: 'canon_450d', description: 'Camera reflex canon'}},
                          name_translations: {en: 'Canon 450D',
                                              es: 'Canon 450D'},

                          short_description_translations: {en: 'Camera reflex canon 12MP.',
                                                           es: 'Camera reflex canon 12MP.'},

                          description_translations: {en: 'Camera reflex canon 12 MP (not includes SD).',
                                                     es: 'Camera reflex canon 12 MP (not includes SD).'},

                          barcode: '123456789',
                          enabled: true,
                          visible: true,

                          retail_price_pre_tax: 350.0,
                          retail_price: 423.5,
                          tax: tax_iva,

                          slug_translations: {en: 'canon_450d', es: 'canon_450d'},
                          stock: 100,
                          control_stock: true,
                          image: camera_image}

    create_product(product_attributes, categories, tags)

    camera_image = File.new "#{Rails.root}/app/assets/images/products/nikon_d5500.png"
    product_attributes = {reference_code: 'ref2',
                          meta_tags_translations: {en: {keywords: 'nikon_D5500-24mm', description: 'Camera reflex nikon'},
                                                   es: {keywords: 'nikon_D5500-24mm', description: 'Camera reflex nikon'}},
                          name_translations: {en: 'Nikon D5500',
                                              es: 'Nikon D5500'},

                          short_description_translations: {en: 'Camera reflex Nikon 24MP.',
                                                           es: 'Camera reflex Nikon 24MP.'},

                          description_translations: {en: 'Camera reflex Nikon 24 MP (not includes SD).',
                                                     es: 'Camera reflex Nikon 24 MP (not includes SD).'},

                          barcode: '1234567890',
                          enabled: true,
                          visible: true,

                          retail_price_pre_tax: 350.0,
                          retail_price: 423.5,
                          tax: tax_iva,

                          slug: 'nikon_d5500',
                          stock: 100,
                          control_stock: true,
                          image: camera_image}

    create_product(product_attributes, categories, tags)

    tag_lenses = Tag.find_by('lower(tags.name_translations->?) LIKE lower(?)', 'en', '%Lenses%')
    tags = [tag_lenses]

    category = Category.find_by(reference_code: PHOTOGRAPHY_LENSES_SLUG)
    categories = [category]

    zoom_image = File.new "#{Rails.root}/app/assets/images/products/DX-Zoom-10-24mm.png"
    product_attributes = {reference_code: 'ref3',
                          meta_tags_translations: {en: {keywords: 'dx_zoom_10-24mm', description: 'Zoom reflex nikon'},
                                                   es: {keywords: 'dx_zoom_10-24mm', description: 'Zoom reflex nikon'}},
                          name_translations: {en: 'AF-S DX 10-24mm',
                                              es: 'AF-S DX 10-24mm'},

                          short_description_translations: {en: 'AF-S DX Zoom-NIKKOR 10-24mm f/3.5-4.5G ED.',
                                                           es: 'AF-S DX Zoom-NIKKOR 10-24mm f/3.5-4.5G ED.'},

                          description_translations: {en: 'AF-S DX Zoom-NIKKOR 10-24mm f/3.5-4.5G ED.',
                                                     es: 'AF-S DX Zoom-NIKKOR 10-24mm f/3.5-4.5G ED.'},

                          barcode: '1234567891',
                          enabled: true,
                          visible: true,

                          retail_price_pre_tax: 350.0,
                          retail_price: 423.5,
                          tax: tax_iva,

                          slug: 'zoom-nikkor-10-24mm',
                          stock: 100,
                          control_stock: true,
                          image: zoom_image}

    create_product(product_attributes, categories, tags)
  end

  def create_phones_products
    category = Category.find_by(reference_code: PHONES_SMART_PHONES_SLUG)
    categories = [category]

    tax_iva = Tax.find_by(name: 'IVA ES 21%')

    camera_image = File.new "#{Rails.root}/app/assets/images/products/Huawei-Ascend-G630.png"
    product_attributes = {reference_code: 'ref4',
                          meta_tags_translations: {en: {keywords: 'huawei', description: 'huawei smartphone'},
                                                   es: {keywords: 'huawei', description: 'huawei smartphone'}},
                          name_translations: {en: 'Huawei Ascend G630 white 5" HD & 8MP',
                                              es: 'Huawei Ascend G630 white 5" HD & 8MP'},

                          short_description_translations: {en: 'AF-S DX Zoom-NIKKOR 10-24mm f/3.5-4.5G ED.',
                                                           es: 'Sé el más de la clase (aunque ya ni vayas) y hazte ya con el móvil Huawei Ascend G630, que te dará todo lo que buscas en un smartphone, pero con el precio que aún no encontrabas...'},

                          description_translations: {en: 'AF-S DX Zoom-NIKKOR 10-24mm f/3.5-4.5G ED.',
                                                     es: '<p>Sé el más de la clase (aunque ya ni vayas) y hazte ya con el móvil Huawei Ascend G630, que te dará todo lo que buscas en un smartphone, pero con el precio que aún no encontrabas.</p>
<p>Tu querías una pantalla grande y él te ofrece 5 pulgadas de resolución HD con tecnología IPS, para que disfrutes de todo tu mundo a lo grande y con gran calidad de detalle.</p>
<p>Buscabas una cámara con buena resolución y Huawei pone a tu servicio 8 Megapíxeles con enfoque automático y otra cámara frontal de 1 Mpx. para que puedas hacer vídeollamadas y retratos con total cómodidad.</p>
<p>Ansiabas velocidad y con el G630 la tendrás gracias a su potente procesador Quad Core, que sumado a la memoria RAM de 1GB da un resultado multi-tarea increíble.</p>
<p>Además tendrás a tu disposición todo tipo de conexiones para compartir tu mundo, como el NFC, Bluetooth, WiFi y el mejor sonido DTS.</p>
<p>Como te decía... Huawei Ascend G630 tiene todo lo que buscas, ¡incluido el precio!</p>'},

                          barcode: '12321321312',
                          enabled: true,
                          visible: true,

                          retail_price_pre_tax: 100.0,
                          retail_price: 121.0,
                          tax: tax_iva,

                          slug: 'huawei-ascend-g630',
                          stock: 100,
                          control_stock: true,
                          image: camera_image}

    create_product(product_attributes, categories, [])
  end

  desc 'Generate demo users'
  task :gen_demo_products => :environment do
    puts '####################'
    puts '## Creating products'
    puts '####################'

    create_photograpy_products
    create_phones_products
  end
end