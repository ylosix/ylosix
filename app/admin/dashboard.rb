ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    panel 'Variables' do
      current_config = Rails.application.config
      config_db = current_config.database_configuration[Rails.env]
      updates = `cd #{Rails.root}; git fetch; git rev-list HEAD...origin/develop --count`

      columns do
        column do
          span 'Version'
        end

        column do
          span Ecommerce::Version.dup
        end
      end

      columns do
        column do
          span 'Environment'
        end

        column do
          span Rails.env
        end
      end

      columns do
        column do
          span 'Root folder'
        end

        column do
          span Rails.root
        end
      end

      columns do
        column do
          span 'Database'
        end

        column do
          span config_db['database']
        end
      end

      columns do
        column do
          span 'Database adapter'
        end

        column do
          span config_db['adapter']
        end
      end

      columns do
        column do
          span 'GIT status'
        end

        column do
          if updates.to_i == 0
            span 'Up-to-date'
          else
            span "The repository has #{updates} updates."
          end
        end
      end
    end
  end # content
end
