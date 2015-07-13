namespace :db do
  def create_address(attributes = {})
    saddress = CustomerAddress.new(attributes)

    unless saddress.customer.nil?
      saddress.customer_name = saddress.customer.name
      saddress.customer_last_name = saddress.customer.last_name
    end

    saddress.address_1 = 'Rambla Nova, 72'
    saddress.postal_code = '43002'
    saddress.city = 'Tarragona'
    saddress.country = 'ES'
    saddress.phone = '977112233'
    saddress.mobile_phone = '616112233'
    saddress.dni = '123456789T'

    saddress.save
  end

  desc 'Generate demo users'
  task :gen_demo_users => :environment do
    puts '####################'
    puts '## Creating default user'
    puts '####################'

    customer = Customer.find_by(:email => 'customer@ylosix.com')
    if customer.nil?
      customer = Customer.create!(:email => 'customer@ylosix.com',
                                  :name => 'Ylos',
                                  :last_name => 'Hispania',
                                  :birth_date => DateTime.now,
                                  :password => 'password',
                                  :locale => 'en',
                                  :password_confirmation => 'password')
    end

    if customer.customer_addresses.empty?
      create_address({name: 'My billing address',
                      customer: customer,
                      default_billing: true,
                      default_shipping: false})
      create_address({name: 'My shipping address',
                      customer: customer,
                      default_billing: false,
                      default_shipping: true})
    end
  end
end