namespace :db do
  desc 'Generate demo commerce'
  task :gen_demo_carriers => :environment do
    puts '####################'
    puts '## Creating carriers'
    puts '####################'

    carrier_attributes = {:name => 'Shop pick up', delay: '24h', :locale => :en}
    carrier_attributes_all = carrier_attributes.clone
    carrier_attributes_all[:enabled] = true
    carrier_attributes_all[:free_carrier] = true
    carrier = Utils.create_model_translations(Carrier,
                                                       :carrier_translations,
                                                       carrier_attributes,
                                                       carrier_attributes_all)

    ct = CarrierTranslation.find_or_create_by(carrier: carrier, locale: :es)
    ct.attributes = {delay: '24h', name: 'Recogida en tienda'}
    ct.save
  end
end