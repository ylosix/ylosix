# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

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
  available_locales.each do |locale|
    name = 'English'
    name = 'Español' if locale == 'es'

    flag_file = File.new "#{Rails.root}/app/assets/images/flags/#{locale}.png"
    language_attributes = {:locale => locale,
                           :name => name,
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
end

create_defaults