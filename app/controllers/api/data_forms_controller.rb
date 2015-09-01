module Api
  class DataFormsController < ApplicationController
    def create
      @dataform = DataForm.create(data_forms_params)
      @dataform.fields[:locale] = session[:locale] unless session[:locale].blank?

      if @dataform.errors.any?
        render nothing: true, status: :bad_request
      else
        @dataform.action_forms.each do |action_form|
          action_form.perform_with_data(@dataform)
        end

        render nothing: true, status: :ok
      end
    end

    private

    def data_forms_params
      keys = params.require(:data_form)[:fields].keys
      params.require(:data_form).permit(:tag, fields: keys)
    end
  end
end
