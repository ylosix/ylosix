class OpenFormsController < ApplicationController
  def create
    @openform = OpenForm.create(open_forms_params)

    if @openform.errors.any?
      render nothing: true, status: :bad_request
    else
      render nothing: true, status: :ok
    end
  end

  private

  def open_forms_params
    keys = params.require(:open_form)[:fields].keys
    params.require(:open_form).permit(:tag, fields: keys)
  end
end
