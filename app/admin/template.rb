ActiveAdmin.register Template do
  menu parent: 'Design'

  permit_params :name, :path, :enabled
  actions :all, except: [:new, :delete]

  controller do
    def save_files(template)
      template.writes_files(params[:template])
    end

    def update
      super

      template = Template.find(params[:id])
      save_files(template)
    end

    def export
      template = Template.find(params[:id])
      zip_file_path = Utils.zip_folder(template.absolute_path)

      options = { filename: "#{template.name}.zip", type: 'application/zip' }
      send_file(zip_file_path, options)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :path
    column :enabled
    column(:export) { |template| link_to 'Export', admin_export_template_path(template) }
    actions
  end

  form do |f|
    f.inputs 'Template Details' do
      template = f.object
      f.input :name
      f.input :path
      f.input :enabled

      locals_files = template.get_local_files
      render partial: '/admin/templates/edit_files', locals: locals_files
    end
    f.actions
  end
end
