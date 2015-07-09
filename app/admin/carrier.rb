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

      f.input :image, hint: (f.template.image_tag(carrier.image.url(:original)) if carrier.image?)

      f.input :enabled
      f.input :free_carrier
    end
    f.actions
  end
end
