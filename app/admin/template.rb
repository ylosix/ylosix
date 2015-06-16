ActiveAdmin.register Template do
  menu parent: 'Design'

  permit_params :name, :path, :enabled
  actions :all, except: [:new, :delete]

  action_item :view, only: :index do
    link_to 'Import template', import_admin_templates_path
  end

  # Export template
  action_item :view, only: :show do
    link_to('Export template', admin_export_template_path(template))
  end

  collection_action :import, method: [:get, :post] do
    if request.get?
      render partial: '/admin/templates/import'
    elsif request.post?
      notice = ''

      file_data = params[:template][:file]
      if file_data.respond_to?(:read)
        name = params[:template][:file].original_filename
        name = name.split('.')[0]

        template = Template.find_or_create_by(name: name)
        template.path = "/public/templates/#{DateTime.now.to_i}"
        template.enabled = false
        template.save

        Utils.zip_extract(template.absolute_path, file_data.tempfile)
        notice = 'Template imported successfully!'
      end

      redirect_to collection_path, notice: notice
    end
  end

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

    def destroy
      template = Template.find(params[:id])
      FileUtils.rm_rf(template.absolute_path)

      super
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :path
    column :enabled
    column(:export) { |template| link_to 'Export', admin_export_template_path(template) }
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Template Details' do
      template = f.object
      f.input :name
      f.input :path
      f.input :enabled

      locals_files = template.files
      render partial: '/admin/templates/edit_files', locals: { files: locals_files }
    end
    f.actions
  end
end
