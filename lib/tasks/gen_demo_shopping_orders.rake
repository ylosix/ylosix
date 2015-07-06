namespace :db do
  desc 'Generate demo commerce'
  task :gen_demo_shopping_orders => :environment do
    puts '####################'
    puts '## Creating shopping orders'
    puts '####################'

    customer = Customer.find_by(email: 'customer@ylosix.com')
    sc = customer.shopping_cart
    so = ShoppingOrder.new(customer: customer)

    sc.shopping_carts_products.each do |scp|
      so.shopping_orders_products << scp.to_shopping_order
    end

    so.shipping_address = customer.customer_addresses.first.fields
    so.billing_address = customer.customer_addresses.first.fields

    commerce = Commerce.first
    so.billing_commerce = commerce.billing_address
    so.save
  end
end