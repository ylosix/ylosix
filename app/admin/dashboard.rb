ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    panel 'Variables' do
      current_config = Rails.application.config

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

      config_db = current_config.database_configuration[Rails.env]

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
          updates = `cd #{Rails.root}; git rev-list HEAD...origin/develop --count`

          if updates.to_i == 0
            span 'Up-to-date'
          else
            span "The repository has #{updates} updates."
          end
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
