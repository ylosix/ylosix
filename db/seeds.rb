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

  tag_cameras = Tag.find_by(:name => 'Cameras')
  tag_reflex = Tag.find_by(:name => 'Reflex')

  product = Product.find_by(:reference_code => 'ref1')
  product_attributes = {:reference_code => 'ref1',
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

                        :meta_keywords => 'canon_450d',
                        :meta_description => 'Camera reflex canon',
                        :slug => 'canon_450d',
                        :stock => 100,
                        :control_stock => true,
                        :image => camera_image}

  if product.nil?
    product = Product.create!(product_attributes)
  else
    product.attributes = product_attributes
  end

  product.categories = [category]
  product.tags = [tag_cameras, tag_reflex]
  product.save
end

def create_default_categories
  puts '####################'
  puts '## Creating categories'
  puts '####################'

  root = Category.find_by(:slug => 'root')
  root_attributes = {:parent_id => nil,
                     :name => 'root',
                     :enabled => true,
                     :appears_in_web => false,
                     :slug => 'root'}

  if root.nil?
    root = Category.create!(root_attributes)
  else
    root.attributes = root_attributes
    root.save
  end

  category_cam = Category.find_by(:slug => 'digital_cameras')
  category_cam_attributes = {:parent_id => root.id,
                             :name => 'Digital Cameras',
                             :enabled => true,
                             :appears_in_web => true,
                             :slug => 'digital_cameras'}

  if category_cam.nil?
    Category.create!(category_cam_attributes)
  else
    category_cam.attributes = category_cam_attributes
    category_cam.save
  end
end


def create_default_tags
  puts '####################'
  puts '## Creating tags'
  puts '####################'

  tag_cameras = Tag.find_by(:name => 'Cameras')
  if tag_cameras.nil?
    tag_cameras = Tag.create!(:parent_id => nil,
                              :name => 'Cameras',
                              :appears_in_web => true)
  end

  tag_reflex = Tag.find_by(:name => 'Reflex')
  if tag_reflex.nil?
    Tag.create!(:parent_id => tag_cameras.id,
                :name => 'Reflex',
                :appears_in_web => true)
  end
end


create_default_languages
create_default_roles
create_default_admin_user
create_default_categories
create_default_tags
create_default_products