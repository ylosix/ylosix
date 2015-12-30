namespace :db do
  desc 'Generate demo commerce'
  task :gen_demo_carriers => :environment do
    puts '####################'
    puts '## Creating carriers'
    puts '####################'

    carrier_attributes = {name_translations: {en: 'Shop pick up', es: 'Recogida en tienda'},
                          delay_translations: {en: '24h', es: '24h'}}
    carrier_attributes_all = carrier_attributes.clone
    carrier_attributes_all[:enabled] = true
    carrier_attributes_all[:free_carrier] = true

    Utils.create_model_translations(Carrier,
                                    carrier_attributes,
                                    carrier_attributes_all)
  end
end