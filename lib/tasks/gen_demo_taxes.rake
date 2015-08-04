namespace :db do
  desc 'Generate demo commerce'
  task :gen_demo_taxes => :environment do
    puts '####################'
    puts '## Creating default taxes'
    puts '####################'

    iva_es_attributes = {:name => 'IVA ES 21%', :rate => 21.0}
    Utils.create_or_update_model(Tax, {:name => 'IVA ES 21%'}, iva_es_attributes)
  end
end