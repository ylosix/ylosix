# == Schema Information
#
# Table name: carriers
#
#  created_at         :datetime         not null
#  delay_translations :hstore           default({}), not null
#  enabled            :boolean          default(FALSE), not null
#  free_carrier       :boolean          default(FALSE), not null
#  id                 :integer          not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  name_translations  :hstore           default({}), not null
#  priority           :integer          default(1), not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_carriers_on_enabled  (enabled)
#

ActiveAdmin.register Carrier do
  menu parent: 'Transports', if: proc { commerce && commerce.enable_commerce_options }

  permit_params do
    permitted = [:enabled, :free_carrier, :image]

    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {name_translations: locales}
    permitted << {delay_translations: locales}
    permitted
  end

  index do
    selectable_column
    id_column
    column :name
    column (:image) { |carrier| image_tag(carrier.image.url(:original)) if carrier.image? }
    column :delay

    column :enabled
    column :free_carrier
    actions
  end

  filter :name
  filter :enabled
  filter :free_carrier

  form do |f|
    f.inputs 'Carrier details' do
      admin_translation_text_field(carrier, 'carrier', 'name_translations')
      admin_translation_text_field(carrier, 'carrier', 'delay_translations')

      f.input :image, hint: (image_tag(carrier.image.url(:original)) if carrier.image?)

      f.input :enabled
      f.input :free_carrier
    end

    f.inputs 'Zone prices' do
      render partial: 'admin/carriers/zone_prices', locals:
                                                      {
                                                          zones: Zone.all,
                                                          carrier_ranges_groups: CarriersRange
                                                                                     .where(carrier: resource)
                                                                                     .group(:greater_equal_than, :lower_than)
                                                                                     .select(:greater_equal_than, :lower_than),

                                                          carrier_ranges: CarriersRange.where(carrier: resource)
                                                      }
    end

    f.actions
  end

  controller do
    def create
      super

      update_carrier_ranges
    end

    def update
      super

      update_carrier_ranges
    end

    private

    def update_carrier_ranges
      CarriersRange.destroy_all(carrier: resource)

      unless params[:carriers_ranges].blank?
        params[:carriers_ranges].each do |hash|
          hash.each do |_k, parameters|
            next if parameters.size != 3

            parameters[:zones].each do |zone_param|
              next if zone_param.size != 2

              attributes = params_carrier_range(parameters.except(:zones).merge(zone_param))

              carrier_range = CarriersRange.new(attributes)
              carrier_range.carrier = resource
              carrier_range.save
            end
          end
        end
      end
    end

    def params_carrier_range(parameters)
      parameters.permit(:zone_id, :greater_equal_than, :lower_than, :amount)
    end
  end
end
