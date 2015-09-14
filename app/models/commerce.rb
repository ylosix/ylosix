# == Schema Information
#
# Table name: commerces
#
#  billing_address           :hstore           default({}), not null
#  created_at                :datetime         not null
#  default                   :boolean
#  ga_account_id             :string
#  http                      :string
#  id                        :integer          not null, primary key
#  language_id               :integer
#  logo_content_type         :string
#  logo_file_name            :string
#  logo_file_size            :integer
#  logo_updated_at           :datetime
#  meta_description          :string
#  meta_keywords             :string
#  name                      :string
#  no_redirect_shopping_cart :boolean          default(FALSE), not null
#  order_prefix              :string           default(""), not null
#  social_networks           :hstore           default({}), not null
#  template_id               :integer
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_commerces_on_template_id  (template_id)
#
# Foreign Keys
#
#  fk_rails_f6f5a5f253  (template_id => templates.id)
#

class Commerce < ActiveRecord::Base
  attr_accessor :template_from

  belongs_to :template
  belongs_to :language
  has_many :shopping_orders

  has_attached_file :logo, styles: {original: '300x100'}

  validates_attachment_size :logo, less_than: 2.megabytes
  validates_attachment_content_type :logo, content_type: %r{\Aimage/.*\Z}

  store_accessor :billing_address, :name, :address_1, :address_2, :postal_code,
                 :city, :country, :phone, :cif

  def self.retrieve(http)
    commerce = Commerce.find_by(http: http)

    commerce ||= Commerce.find_by(default: true)
    commerce ||= Commerce.new

    commerce.template_from = 'commerce'
    commerce
  end

  def to_liquid
    image_src = 'http://placehold.it/300x100'
    image_src = logo.url(:original) if logo?

    template_liquid = nil
    template_liquid = template.to_liquid unless template.blank?

    {
        'http' => http,
        'image_src' => image_src,
        'meta_description' => meta_description,
        'meta_keywords' => meta_keywords,
        'name' => name,
        'billing_address' => billing_address,
        'root_href' => Rails.application.routes.url_helpers.root_path,
        'template' => template_liquid,
        'template_from' => template_from,
        'ga_account_id' => ga_account_id,
        'order_prefix' => order_prefix,
        'social_networks' => social_networks
    }
  end
end
