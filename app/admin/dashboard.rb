ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    current_config = Rails.application.config
    config_db = current_config.database_configuration[Rails.env]
    updates = `cd #{Rails.root}; git fetch; git rev-list HEAD...origin/develop --count`

    commerce = Commerce.find_by(default: true)
    unless commerce.nil?
      panel 'Default commerce' do
        columns do
          column do
            span 'Commerce'
          end

          column do
            span auto_link commerce
          end
        end

        columns do
          column do
            span 'Http'
          end

          column do
            span commerce.http
          end
        end

        columns do
          column do
            span 'Name'
          end

          column do
            span commerce.name
          end
        end

        columns do
          column do
            span 'Billing address'
          end

          column do
            span commerce.billing_address
          end
        end

        columns do
          column do
            span 'Logo'
          end

          column do
            (img src: commerce.logo.url(:original)) if commerce.logo?
          end
        end

        columns do
          column do
            span 'Template'
          end

          column do
            span auto_link commerce.template
          end
        end
      end
    end

    panel 'Frontend variables' do
      columns do
        column do
          span 'Debug variables'
        end

        column do
          span current_admin_user.debug_variables ? 'Yes' : 'No'
        end
      end

      columns do
        column do
          span 'Debug template'
        end

        column do
          span auto_link current_admin_user.debug_template
        end
      end
    end

    panel 'Application variables' do
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
