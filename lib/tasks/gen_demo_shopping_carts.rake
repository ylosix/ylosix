namespace :db do
  desc 'Generate demo commerce'
  task :gen_demo_shopping_carts => :environment do
    puts '####################'
    puts '## Creating shopping carts'
    puts '####################'

    customer = Customer.find_by(email: 'customer@ylosix.com')
    sc = ShoppingCart.new(customer: customer)

    products = Product.where(enabled: true)

    sc.add_product(products[0])
    sc.add_product(products[1])

    sc.save
  end
end