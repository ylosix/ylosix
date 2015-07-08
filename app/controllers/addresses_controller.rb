class AddressesController < Frontend::CommonController
  before_action :authenticate_customer!
  before_action :set_customer_address, except: [:index, :new, :create]

  def get_template_variables(template)
    super

    helper = Rails.application.routes.url_helpers
    @variables['customer_new_address_href'] = helper.new_customers_address_path
    if customer_signed_in?
      # @variables['customer_addresses'] = CustomerAddress.from_user(current_customer)
      @variables['customer_addresses'] = current_customer.customer_addresses
    end

    @variables['countries'] = Country.where(enabled: true)
  end

  def index
  end

  def edit
    add_breadcrumb(Breadcrumb.new(url: edit_customers_address_path, name: 'Edit'))
  end

  def create
    @address = CustomerAddress.new(address_params)
    @address.customer = current_customer
    @address.save

    if @address.errors.any?
      render 'addresses/new'
    else
      redirect_to :customers_addresses, notice: 'Address saved successfully!'
    end
  end

  def update
    @address.attributes = address_params
    @address.save

    if @address.errors.any?
      render 'addresses/edit'
    else
      redirect_to :customers_addresses, notice: 'Address saved successfully!'
    end
  end

  def destroy
    @address.destroy
    redirect_to :customers_addresses, notice: 'Address destroyed successfully!'
  end

  def new
    @address = CustomerAddress.new

    @address.name = 'My address'
    @address.customer_name = current_customer.name
    @address.customer_last_name = current_customer.last_name
  end

  protected

  def set_breadcrumbs
    add_breadcrumb(Breadcrumb.new(url: show_customers_path, name: 'Customers'))
    add_breadcrumb(Breadcrumb.new(url: customers_addresses_path, name: 'Addresses'))
  end

  def set_customer_address
    @address = CustomerAddress.find(params[:id])
  end

  def address_params
    params.require(:customer_address).permit(:name, :default_billing, :default_shipping,
                                             :customer_name, :customer_last_name,
                                             :business, :address_1, :address_2,
                                             :postal_code, :city, :country,
                                             :phone, :mobile_phone, :state,
                                             :dni, :other)
  end
end
