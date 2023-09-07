# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "time"
require "date"

puts "Cleaning database..."
User.destroy_all
SellProduct.destroy_all
Sell.destroy_all


# ShopProduct.destroy_all pas besoin de le mettre puisque le dependent destroy le tue
Shop.destroy_all
Order.destroy_all
Product.destroy_all

puts "Creating user..."
User.create!(first_name: "Galmier", last_name: "Forissier", email: "galmier@mail.com", password: "123456")
puts "User created..."

puts "Creating shop..."
# shop = Shop.create!(name: "Magasin n°1", address: "2 avenue des saules, 59000 Lille", surface: 19.5, capacity: 500)
shop = Shop.create!(name: "Magasin n°2", address: "3 avenue des saules, 59000 Lille", surface: 20, capacity: 500)
puts "Shop created..."

puts "Creating products"
filepath = "./db/data.json"
serialized_panima = File.read(filepath)
products = JSON.parse(serialized_panima)

def category_prod(product)
  if product["category"].class != String
    return product["category"].first
  else
    return product["category"]
  end
end

products.each do |product|
  Product.create!(name: product["name"], description: product["description"], buy_price: product["price"]["USD"]["default"], category: category_prod(product), ean: product["id"] )
end

puts "Products created..."

puts "Creating shop_products"
shop_products = Product.all.sample(50)
shop_products.each do |shop_product|
  ShopProduct.create!(shop_id: shop.id, product_id: shop_product.id, stock: rand(0..10), rack: rand(1..50), selling_price: (shop_product.buy_price*1.20), max_stock: 10, rating: rand(0..100), status:"ok", permanent: false )
end
puts "Shop_products created..."

puts "Creating Orders"

to_day = Time.now
yesterday = Time.now - 1.day
two_days = Time.now - 2.day
three_days = 10.days.from_now

Order.create!(order_reference: [*'a'..'z', *0..9, *'A'..'Z'].sample(7).join, quantity: 180, total_price: 3223, supplier: "alexzoonekynd@hotmail.com", status:"En cours", delivered_date: to_day, shop_id: Shop.last.id)
Order.create!(order_reference: [*'a'..'z', *0..9, *'A'..'Z'].sample(7).join, quantity: 110, total_price: 2716, supplier: "alexzoonekynd@hotmail.com", status:"Annulée", delivered_date: yesterday, shop_id: Shop.last.id)
Order.create!(order_reference: [*'a'..'z', *0..9, *'A'..'Z'].sample(7).join, quantity: 116, total_price: 2965, supplier: "alexzoonekynd@hotmail.com", status:"Terminée", delivered_date: two_days, shop_id: Shop.last.id)
Order.create!(order_reference: [*'a'..'z', *0..9, *'A'..'Z'].sample(7).join, quantity: 147, total_price: 3043, supplier: "alexzoonekynd@hotmail.com", status:"Validée", delivered_date: three_days, shop_id: Shop.last.id)

puts "Orders created..."


puts "creating sold products"

# Get some products and orders for generating seed data
products = Product.all
orders = Order.all

# Create a new Sell record
date_range_start = Date.today.at_beginning_of_month
date_range_end = Date.today
(date_range_start..date_range_end).each do |date|
  sell = Sell.create!(
    user_id: User.first.id,
    total_price: 1,
    created_at: date
  )
  5.times do
    # Generate a random quantity between 1 and 10
    quantity = rand(1..30)
    # Generate a random sold date within the last month
    # Create the sell product
    SellProduct.create!(
      sell: sell,
      shop_product: ShopProduct.find(ShopProduct.pluck(:id).sample),
      quantity: quantity,
      created_at: date
    )
  end
  total_price = 0
  products_for_sell = SellProduct.where(sell_id: sell.id)
  products_for_sell.each do |product|
    price = product.shop_product.selling_price * product.quantity
    total_price += price
  end
  sell.total_price = total_price
  sell.save
end
