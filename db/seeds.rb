# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def create_default_roles
  puts '####################'
  puts '## Creating default roles'
  puts '####################'

  role_admin = Role.find_by(:name => 'Client')
  Role.create!(:name => 'Admin') if role_admin.nil?

  role_user = Role.find_by(:name => 'Client')
  Role.create!(:name => 'Client') if role_user.nil?
end

def create_default_admin_user
  puts '####################'
  puts '## Creating default admin user'
  puts '####################'

  admin = AdminUser.find_by(:email => 'admin@example.com')
  if admin.nil?
    AdminUser.create!(:email => 'admin@example.com', :password => 'password',
                      :password_confirmation => 'password')
  end
end

def create_default_languages
  puts '####################'
  puts '## Creating default languages'
  puts '####################'

  language_codes = %w(gb es)

  language_codes.each do |lang_code|

    language = Language.find_by(:code => lang_code)
    if language.nil?
      flag_file = File.new "#{Rails.root}/app/assets/images/flags/#{lang_code}.png"
      Language.create!(:code => lang_code,
                       :flag => flag_file,
                       :appears_in_backoffice => true,
                       :appears_in_web => true)
    end
  end
end

def create_default_products
  puts '####################'
  puts '## Creating products'
  puts '####################'

  category = Category.find_by_slug('digital_cameras')
  camera_image = File.new "#{Rails.root}/app/assets/images/products/camera.png"

  product = Product.find_by(:reference_code => 'ref1')
  if product.nil?
    Product.create!(:reference_code => 'ref1',
                    :name => 'Canon 450D',
                    :barcode => '123456789',
                    :enabled => true,
                    :appears_in_categories => true,
                    :appears_in_tag => true,
                    :appears_in_search => true,
                    :short_description => 'Camera reflex canon 12MP.',
                    :description => 'Camera reflex canon 12 MP (not includes SD).',

                    :retail_price_pre_tax => 350.0,
                    :retail_price => 423.5,
                    :tax_percent => 21.0,

                    :meta_title => 'canon_450d',
                    :meta_description => 'Camera reflex canon',
                    :slug => 'canon_450d',
                    :stock => 100,
                    :control_stock => true,
                    :image => camera_image,
                    :categories => [category])
  end
end

def create_default_categories
  puts '####################'
  puts '## Creating categories'
  puts '####################'

  root = Category.find_by(:slug => 'root')
  if root.nil?
    root = Category.create!(:parent_id => nil,
                            :name => 'root',
                            :appears_in_web => false,
                            :slug => 'root')
  end

  category_cam = Category.find_by(:slug => 'digital_cameras')
  if category_cam.nil?
    Category.create!(:parent_id => root.id,
                     :name => 'Digital Cameras',
                     :appears_in_web => true,
                     :slug => 'digital_cameras')
  end

end


create_default_languages
create_default_roles
create_default_admin_user
create_default_categories
create_default_products