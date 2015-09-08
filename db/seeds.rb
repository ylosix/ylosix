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

    Utils.create_or_update_model(Language, {:locale => locale}, language_attributes)
  end
end


def create_default_ylos_template
  puts '####################'
  puts '## Creating ylos template'
  puts '####################'

  ylos_template = {:name => 'ylos',
                   :path => '/public/templates/ylos',
                   :enabled => false}
  Utils.create_or_update_model(Template, {:name => 'ylos'}, ylos_template)
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
  Utils.create_or_update_model(Commerce, {name: 'Demo ylosix'}, commerce_attributes)
end


def create_defaults_statuses
  puts '####################'
  puts '## Creating default statuses'
  puts '####################'

  sos_accepted_attributes = {shopping_orders_status_translations_attributes: [{locale: :en, name: 'Payment accepted'},
                                                                              {locale: :es, name: 'Pago aceptado'}],
                             enable_invoice: true,
                             color: '#32CD32'}
  Utils.create_or_update_model(ShoppingOrdersStatus, {:color => '#32CD32'}, sos_accepted_attributes)

  sos_accepted_attributes = {shopping_orders_status_translations_attributes: [{locale: :en, name: 'Packaging'},
                                                                              {locale: :es, name: 'Preparando el paquete'}],
                             enable_invoice: true,
                             color: '#FF8C00'}
  Utils.create_or_update_model(ShoppingOrdersStatus, {:color => '#FF8C00'}, sos_accepted_attributes)


  sos_accepted_attributes = {shopping_orders_status_translations_attributes: [{locale: :en, name: 'Sent'},
                                                                              {locale: :es, name: 'Enviado'}],
                             enable_invoice: true,
                             color: '#8A2BE2'}
  Utils.create_or_update_model(ShoppingOrdersStatus, {:color => '#8A2BE2'}, sos_accepted_attributes)

  sos_accepted_attributes = {shopping_orders_status_translations_attributes: [{locale: :en, name: 'Committed'},
                                                                              {locale: :es, name: 'Entregado'}],
                             enable_invoice: true,
                             color: '#108510'}
  Utils.create_or_update_model(ShoppingOrdersStatus, {:color => '#108510'}, sos_accepted_attributes)

  sos_accepted_attributes = {shopping_orders_status_translations_attributes: [{locale: :en, name: 'Canceled'},
                                                                              {locale: :es, name: 'Cancelado'}],
                             enable_invoice: false,
                             color: '#DC143C'}
  Utils.create_or_update_model(ShoppingOrdersStatus, {:color => '#DC143C'}, sos_accepted_attributes)
end

def create_default_category
  puts '####################'
  puts '## Creating default category'
  puts '####################'

  root_attributes = {:parent_id => nil,
                     category_translations_attributes: [{locale: :en, name: 'Root', slug: 'root'},
                                                        {locale: :es, name: 'Inicio', slug: 'inicio'}],
                     :enabled => true,
                     :visible => true}
  Utils.create_or_update_model(Category, {:reference_code => 'root'}, root_attributes)
end

def create_defaults
  create_default_languages
  create_default_ylos_template
  create_default_commerce
  create_default_admin_user
  create_default_countries
  create_defaults_statuses
  create_default_category
end

create_defaults