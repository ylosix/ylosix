# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def save_or_update_model(model, search_options, attributes)
  object = model.find_by(search_options)
  if object.nil?
    object = model.create!(attributes)
  else
    object.attributes = attributes
  end

  object.save
  object
end

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
    AdminUser.create!(:email => 'admin@example.com',
                      :password => 'password',
                      :password_confirmation => 'password')
  end
end

def create_default_languages
  puts '####################'
  puts '## Creating default languages'
  puts '####################'

  language_codes = %w(gb es)
  language_codes.each do |lang_code|
    flag_file = File.new "#{Rails.root}/app/assets/images/flags/#{lang_code}.png"
    language_attributes = {:code => lang_code,
                           :flag => flag_file,
                           :appears_in_backoffice => true,
                           :appears_in_web => true}

    save_or_update_model(Language, {:code => lang_code}, language_attributes)
  end
end

def create_default_products
  puts '####################'
  puts '## Creating products'
  puts '####################'

  category = Category.find_by_slug('digital_cameras')

  tag_cameras = Tag.find_by(:name => 'Cameras')
  tag_reflex = Tag.find_by(:name => 'Reflex')

  camera_image = File.new "#{Rails.root}/app/assets/images/products/camera.png"
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

  product = save_or_update_model(Product, {:reference_code => 'ref1'}, product_attributes)

  product.categories = [category]
  product.tags = [tag_cameras, tag_reflex]
  product.save
end

def create_default_categories
  puts '####################'
  puts '## Creating categories'
  puts '####################'

  root_attributes = {:parent_id => nil,
                     :name => 'root',
                     :enabled => true,
                     :appears_in_web => false,
                     :slug => 'root'}
  root = save_or_update_model(Category, {:slug => 'root'}, root_attributes)

  category_cam_attributes = {:parent_id => root.id,
                             :name => 'Digital Cameras',
                             :enabled => true,
                             :appears_in_web => true,
                             :slug => 'digital_cameras'}
  save_or_update_model(Category, {:slug => 'digital_cameras'}, category_cam_attributes)
end


def create_default_tags
  puts '####################'
  puts '## Creating tags'
  puts '####################'

  tag_cameras_attributes = {:parent_id => nil,
                            :name => 'Cameras',
                            :appears_in_web => true}
  tag_cameras = save_or_update_model(Tag, {:name => 'Cameras'}, tag_cameras_attributes)

  tag_reflex_attributes = {:parent_id => tag_cameras.id,
                           :name => 'Reflex',
                           :appears_in_web => true}
  save_or_update_model(Tag, {:name => 'Reflex'}, tag_reflex_attributes)
end


def create_default_ylos_template
  puts '####################'
  puts '## Creating ylos template'
  puts '####################'

  ylos_template = {:name => 'ylos',
                   :path => '/public/templates/ylos',
                   :enabled => false}
  save_or_update_model(Template, {:name => 'ylos'}, ylos_template)
end


create_default_languages
create_default_roles
create_default_admin_user
create_default_categories
create_default_tags
create_default_products
create_default_ylos_template