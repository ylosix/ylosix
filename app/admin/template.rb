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
  end

  index do
    selectable_column
    id_column
    column :name
    column :path
    column :enabled
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
