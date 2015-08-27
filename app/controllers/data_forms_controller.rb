class DataFormsController < ApplicationController
  def create
    @dataform = DataForm.create(data_forms_params)

    if @dataform.errors.any?
      render nothing: true, status: :bad_request
    else
      render nothing: true, status: :ok
    end
  end

  private

  def data_forms_params
    keys = params.require(:data_form)[:fields].keys
    params.require(:data_form).permit(:tag, fields: keys)
  end
end
