class PagesController < ApplicationController
  # include Groupdate
  # skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @products_to_remove = replace_products[:to_remove]
    @product_to_replace = replace_products[:to_replace]
    @monthly_sales_sum = graph_sales.sum
    @monthly_purchases_sum = purchases.round(2)
    # @profit = @monthly_sales_sum - @cogs_sum
    @profit = 1
    @graph_sales = graph_sales
    @graph_cogs = cogs
    @graph_profit = graph_profit
    @categories = categories
  end

  def graph_profit
    profit_graph = []
    @graph_cogs.each_with_index { |_, index| profit_graph << (@graph_sales[index] - @graph_cogs[index]).round(2) }
    profit_graph
  end

  def graph_sales
    date_range_start = Date.today.at_beginning_of_month
    date_range_end = Date.today
    # Initialize an empty array to store the turnover for each day
    turnover_array = []

    (date_range_start..date_range_end).each do |date|
      # Filter Sell records for the specific day
      sells_for_day = Sell.where(created_at: date.beginning_of_day..date.end_of_day)

      # Calculate the sum of total prices for the sells of the day
      turnover = sells_for_day.sum(:total_price)
      # Add the turnover to the array
      turnover_array << turnover
    end
    turnover_array
  end

  def cogs
    date_range_start = Date.today.at_beginning_of_month
    date_range_end = Date.today
    # Initialize an empty array to store the turnover for each day
    cogs_array = []

    (date_range_start..date_range_end).each do |date|
      # Filter Sell records for the specific day
      cogs_for_day = SellProduct.where(created_at: date.beginning_of_day..date.end_of_day)
      # Calculate the sum of total prices for the cogs of the day
      cogs_a_day = []
      cogs_for_day.each do |product|
        product = (product.shop_product.product.buy_price * product.quantity).round(2)
        cogs_a_day << product
      end
      cogs_array << cogs_a_day.sum
    end
    cogs_array
  end

  def sales
    revenue = 0
    products_sold = SellProduct.all
    products_sold.each do |product|
      if product.sold_date.month == Date.today.month
        revenue += product.shop_product.selling_price * product.quantity
      end
    end
    revenue
  end

  def purchases
    orders = Order.all
    monthly_orders = []
    orders.each do |order|
      if order.delivered_date.month == Date.today.month
        monthly_orders << order
      end
    end
    purchases = 0
    monthly_orders.each do |order|
      purchases += order.total_price
    end
    purchases
  end

  def replace_products
    replace_products = {
      to_be_replaced: ShopProduct.where(status: "to_remove"),
      to_replace: ShopProduct.where(status: "to_replace")
    }
  end

  def categories
    categories_sales = {}
    products = SellProduct.all
    products = products.group_by {|product| product.shop_product.product.category }
    products.each_key do |value|
      products[value] = products[value].sum { |sell_product| sell_product.quantity * sell_product.shop_product.selling_price }
    end
  end
end
