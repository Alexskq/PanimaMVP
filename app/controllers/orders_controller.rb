require 'date'

class OrdersController < ApplicationController
  def index
    @orders = Order.all.reverse
  end

  def show
    @order = Order.find(params[:id])
    @shop = Shop.first
    @order_products = @order.order_products
    UpdateOrderJob.perform_later(wait_until: Date.tomorrow.noon)
  end

  def pdf
    @order = Order.find(params[:id])
    @shop_products = @order.products
    # order  # ! a décommenter pour créer une commande
    render pdf: "Posts: #{@order}", # filename
    template: "order_mailer/commande",
    formats: [:html],
    disposition: :inline,
    layout: 'pdf'
  end

  # def order
  #   @shop_product_orders = ShopProduct.where(status: ["ok", "to_remove"])
  #   @order = Order.find(params[:id])
  #   @shop_products = []
  #   # @x = OrderProduct.where(product: order.product).where(order_id: params[:id]).first.quantity_product

  #   @shop_product_orders.each do |shop_product_order|
  #     if shop_product_order[:stock] < 5
  #       @new_order_product = OrderProduct.new
  #       @new_order_product.product = shop_product_order.product
  #       @new_order_product.order = @order
  #       @new_order_product.rack = shop_product_order.rack
  #       @new_order_product.quantity_product = shop_product_order.max_stock - shop_product_order.stock
  #       @new_order_product.save
  #       @shop_products.push(shop_product_order)
  #     end
  #   end
  # end

end
