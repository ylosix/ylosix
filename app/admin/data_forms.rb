ActiveAdmin.register DataForm do
  menu parent: 'Preferences'

  permit_params :tag, :fields
  actions :all, except: [:new]

  index do
    selectable_column
    id_column

    column :tag
    column :fields

    actions
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
