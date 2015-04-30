# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def create_default_roles
  puts '####################'
  puts '## Creating default roles'
  puts '####################'
  Role.create!(:name => 'Admin')
  Role.create!(:name => 'Client')
end

def create_default_admin_user
  puts '####################'
  puts '## Creating default admin user'
  puts '####################'
  AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
end

def create_default_languages
  puts '####################'
  puts '## Creating default languages'
  puts '####################'

  language_codes = %w(gb es)

  language_codes.each do |lang_code|
    flag_file = File.new "#{Rails.root}/app/assets/images/flags/#{lang_code}.png"
    Language.create!(:code => lang_code,
                     :flag => flag_file,
                     :appears_in_backoffice => true,
                     :appears_in_web => true)
  end
end

def create_default_products
  puts '####################'
  puts '## Creating products'
  puts '####################'

  Product.create!(:reference_code => 'ref1',
                  :name => 'Canon 450D',
                  :barcode => '123456789',
                  :enabled => true,
                  :appears_in_categories => true,
                  :appears_in_tag => true,
                  :appears_in_search => true,
                  :short_description => 'Camera reflex canon 12MP.',
                  :description => 'Camera reflex canon 12 MP (not includes SD).',

                  :retail_price_pre_tax => 350,
                  :retail_price => 423.5,
                  :tax_percent => 21,

                  :meta_title => 'canon_450d',
                  :meta_description => 'Camera reflex canon',
                  :slug => 'canon_450d',
                  :stock => 100,
                  :control_stock => true)
end


create_default_languages
create_default_roles
create_default_admin_user
create_default_products