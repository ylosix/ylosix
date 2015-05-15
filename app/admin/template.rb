ActiveAdmin.register Template do
  menu parent: 'Design'

  permit_params :name, :path, :enabled, :home_index
  actions :all, except: [:new, :delete]

  after_save do |template|
    template.writes_file('home_index.html', template.home_index)
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

      @home_index = template.reads_file('home_index.html')
      render partial: '/admin/templates/edit_files', locals: { home_index: @home_index }
    end
    f.actions
  end
end
