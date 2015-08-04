module Admin
  module ShoppingOrdersHelper
    def admin_retrieve_array_address(caddress = {})
      address_array = []

      address_array << "#{caddress['name']} #{caddress['customer_name']} #{caddress['customer_last_name']}"
      address_array << "#{caddress['cif']} #{caddress['dni']}"
      address_array << caddress['business']
      address_array << caddress['address_1']
      address_array << caddress['address_2'] unless caddress['address_2'].blank?
      address_array << "#{caddress['postal_code']} #{caddress['city']}"
      address_array << caddress['country']
      address_array << caddress['phone']
      address_array << caddress['mobile_phone']
      address_array << caddress['other']

      address_array
    end
  end
end
