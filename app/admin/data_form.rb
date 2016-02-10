# == Schema Information
#
# Table name: data_forms
#
#  created_at :datetime         not null
#  fields     :hstore           default({}), not null
#  id         :integer          not null, primary key
#  tag        :string
#  updated_at :datetime         not null
#

ActiveAdmin.register DataForm do
  menu parent: 'Preferences'

  permit_params :tag, :fields
  actions :all, except: [:new]

  index do
    selectable_column
    id_column

    column :tag
    column :fields
    column :created_at

    actions
  end

  form do |f|
    f.inputs 'Data form details' do
      f.input :tag
      f.input :fields, as: :text
    end

    f.actions
  end

  controller do
    def update
      super

      @data_form[:fields] = {}
      JSON.parse(params[:data_form][:fields].gsub('=>', ':')).each do |k, v|
        @data_form[:fields][k] = v
      end

      @data_form.save
    end
  end
end
