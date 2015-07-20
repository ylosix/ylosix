# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# /db/country_list.json => List from: http://peric.github.io/GetCountries
def create_default_countries
  puts '####################'
  puts '## Creating default countries'
  puts '####################'

  file = File.read("#{Rails.root}/db/country_list.json")
  data_hash = JSON.parse(file)

  data_hash['countries']['country'].each do |json|
    z = Zone.find_or_create_by(code: json['continent'],
                               name: json['continentName'])
    c = Country.find_or_create_by(zone: z,
                              code: json['countryCode'],
                              name: json['countryName'],
                              iso: json['isoNumeric'])
    if c.code == 'ES'
      c.update_attributes(enabled: true)
    end
  end
end


def create_default_admin_user
  puts '####################'
  puts '## Creating default admin user'
  puts '####################'

  admin = AdminUser.find_by(:email => 'admin@ylosix.com')
  if admin.nil?
    AdminUser.create!(:email => 'admin@ylosix.com',
                      :password => 'password',
                      :password_confirmation => 'password',
                      :debug_variables => true)
  end
end


def create_default_languages
  puts '####################'
  puts '## Creating default languages'
  puts '####################'

  available_locales = %w(en es)
  names = %w(English Español)
  available_locales.each_with_index do |locale, i|
    flag_file = File.new "#{Rails.root}/app/assets/images/flags/#{locale}.png"
    language_attributes = {:locale => locale,
                           :name => names[i],
                           :flag => flag_file,
                           :appears_in_backoffice => true,
                           :appears_in_web => true}

    Utils.save_or_update_model(Language, {:locale => locale}, language_attributes)
  end
end


def create_default_ylos_template
  puts '####################'
  puts '## Creating ylos template'
  puts '####################'

  ylos_template = {:name => 'ylos',
                   :path => '/public/templates/ylos',
                   :enabled => false}
  Utils.save_or_update_model(Template, {:name => 'ylos'}, ylos_template)
end


def create_default_commerce
  puts '####################'
  puts '## Creating commerce'
  puts '####################'

  logo_image = File.new "#{Rails.root}/app/assets/images/ylos-logo.png"
  commerce_attributes = {default: true,
                         http: 'localhost',
                         logo: logo_image,
                         name: 'Demo ylosix',
                         order_prefix: 'DEMO-%Y-%order_num',
                         billing_address: {
                             name: 'Demo ylosix',
                             cif: 'B12345678',
                             city: 'Tarragona',
                             phone: '977112233',
                             country: 'Spain',
                             address_1: 'Rambla Nova, 72',
                             postal_code: '43002'
                         }

  }
  Utils.save_or_update_model(Commerce, {name: 'Demo ylosix'}, commerce_attributes)
end


def create_defaults
  create_default_languages
  create_default_ylos_template
  create_default_commerce
  create_default_admin_user
  create_default_countries
end

create_defaults