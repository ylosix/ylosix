ActiveAdmin.register Carrier do
  menu parent: 'Transport'

  permit_params :enabled, :free_carrier, :name, :image,
                carrier_translations_attributes: [:id, :locale, :name, :delay]

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
      translations = Utils.array_translations(CarrierTranslation, carrier_id: carrier.id)
      admin_translation_text_field(translations, 'carrier', 'name')
      admin_translation_text_field(translations, 'carrier', 'delay')

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
