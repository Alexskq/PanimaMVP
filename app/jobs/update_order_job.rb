class UpdateOrderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Mise à jour de l'inventaire job"

    @order = Order.new(order_reference: [*'a'..'z', *0..9, *'A'..'Z'].sample(7).join, delivered_date: Date.today, quantity: 0, status: "En cours", total_price:valeur_order)
    @order.shop = Shop.first
    @order.save
    @shop_product_orders = ShopProduct.where(status: ["ok", "to_remove"])
    # @x = OrderProduct.where(product: order.product).where(order_id: params[:id]).first.quantity_product

    @shop_product_orders.each do |shop_product_order|

      if shop_product_order.stock < 5
        @new_order_product = OrderProduct.new
        @new_order_product.product = shop_product_order.product
        @new_order_product.order = @order
        @new_order_product.rack = shop_product_order.rack
        @new_order_product.quantity_product = shop_product_order.max_stock - shop_product_order.stock
        @new_order_product.save!
        shop_product_order.stock += @new_order_product.quantity_product
        shop_product_order.save!
      end
    end
    puts "Nouvelle commande prête"
    UpdateOrderJob.set(wait_until: Date.tomorrow.midnight).perform_later
  end

  def valeur_order
    @price_products = Order.last.products
    @total_price = []

    @price_products.each do |product|
      @price = product.buy_price
      @total_price << @price
    end
    puts "-====================="
    puts @total_price.sum
    puts "=================="
    return @total_price.sum
  end
end
