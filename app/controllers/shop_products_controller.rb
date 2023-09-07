require 'time'

class ShopProductsController < ApplicationController
  def index
    @shop_products = ShopProduct.where(status: ["ok", "to_remove"])
    @products = Product.all
    if params[:query].present?
      search_query = params[:query].capitalize
      @shop_products = @shop_products.joins(:product).where("products.name ilike ?", "%#{search_query}%")
    elsif params[:order_by].present?
      @shop_products = ShopProduct.where(status: ["ok", "to_remove"]).order(stock: params[:order_by])
    else
      @shop_products = ShopProduct.all
    end
    stock0()
    total_stock()
    valeur_stock()
    nombre_reference()
    marge()
  end

  def marge
    @mes_shop_products = ShopProduct.where(status: ["ok", "to_remove"])
    @margin = 0
    @mes_shop_products.each do |shop_product|
      @margin += shop_product.selling_price.round - shop_product.product.buy_price.round
    end
  end

  def update
    @shop_product = ShopProduct.find(params[:id])
    if params[:shop_product][:permanent] == "1"
      @shop_product.permanent = true
    else
      params[:shop_product][:permanent] == "0"
      @shop_product.permanent = false
    end
    @shop_product.save
    redirect_to shop_product_path
  end

  def nombre_reference
    @nbref = @shop_products.count
  end

  def valeur_stock
    @valeur = 0
    @mes_shop_products = ShopProduct.where(status: ["ok", "to_remove"])
    @mes_shop_products.each do |shop_product|
      @valeur += shop_product.selling_price.round
    end
  end

  def total_stock
    @total = 0
    @mes_shop_products = ShopProduct.where(status: ["ok", "to_remove"])
    @mes_shop_products.each do |shop_product|
      @total += shop_product.stock
    end
  end

  def stock0
    @mes_shop_products = ShopProduct.where(status: ["ok", "to_remove"])
    @count = 0
    @mes_shop_products.each do |shop_product|
      if shop_product.stock == 0
        @count += 1
      end
    end
  end

  def search_products
    @products = Product.all
    if params[:query].present?
      @products = @products.where(title: params[:query])
    end
  end

  def gamme
    @shop_products = ShopProduct.all.sort_by(&:rating)
    @shop = Shop.first
    @shop_products_last = @shop_products.first(5)
    @shop_product_gamme = ShopProduct.where(status: "ok")
    @shop_products_remove = ShopProduct.where(status: 'to_remove').sort_by(&:rating)
    @shop_products_replace = ShopProduct.where(status: "to_replace")
    @empty_shop_product = ShopProduct.new
    search_products()
    @actualised_time = Actualised.last
  end

  def gamme_auto()

    shop_products = ShopProduct.all.sort_by(&:rating)
    shop_products_last = shop_products.first(5)
    @shop = Shop.first
    new_products = Product.all
    shop_products_last.each do |shop_product|
      shop_product[:status] = "to_remove"
      shop_product.save

      shop_product_new = nil
      new_products.each do |new_product|
        break unless shop_product_new.nil?
        if (new_product[:category] == shop_product.product[:category]) #&& (shop_product[:permanent?] == false)

          if ShopProduct.where(shop: @shop, product: new_product).empty?
            shop_product_new = ShopProduct.create!(shop: @shop, product: new_product, stock: 0, selling_price: (new_product.buy_price*1.20), max_stock: 10, rating: rand(0..100), status:"to_replace", permanent: false )
          end
        end
      end
    end
  end

  def destroy_to_remove
    @shop_products_remove = ShopProduct.where(status: 'to_remove').sort_by(&:rating)
    @shop_products_replace = ShopProduct.where(status: "to_replace")
    all_category = @shop_products_replace.map { |product| product.product.category }

    @shop_products_remove.each do |product|
      unless all_category.include?(product.product.category)
        product.status = "ok"
        product.save
      end
    end

    @shop_products_remove = ShopProduct.where(status: 'to_remove').sort_by(&:rating)
    @shop_products_replace.each do |product_replace|
      product_replace[:status] = "ok"
      product_replace.save
    end

    @shop_products_remove.each do |product_remove|
      if product_remove.permanent? == true
        product_remove[:status] = "ok"
        product_remove.save
      else
        product_remove.destroy
      end
    end
    gamme_auto()
    actualised()
    redirect_to gamme_path
  end


  def actualised()
   Actualised.create!(update_ate: Time.now)
  end


  def replace

    shop_product_instance = shopproduct_params
    shop_product_instance["shop"] = Shop.find(shop_product_instance["shop"].to_i)
    shop_product_instance["product"] = Product.find(shop_product_instance["product"].to_i)
    @shop = Shop.first
    @empty_shop_product = ShopProduct.new(shop_product_instance)
    @empty_shop_product.save
    if @empty_shop_product.save
      @shop_product = ShopProduct.find(params[:shop_product_id])
      @shop_product.update(status: "to_remove")
      @shop_product.save
      redirect_to gamme_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def shopproduct_params
    params.require(:shop_product).permit(:shop, :product, :stock, :selling_price, :max_stock, :status, :rating, :status, :permanent) #-> this is enough (no need to "whitelist")
  end
end


# def create
  #   shop_product_instance = shopproduct_params
  #   shop_product_instance["shop"] = Shop.find(shop_product_instance["shop"].to_i)
  #   shop_product_instance["product"] = Product.find(shop_product_instance["product"].to_i)

  #   @shop = Shop.first
  #   @empty_shop_product = ShopProduct.new(shop_product_instance)
  #   @empty_shop_product.save
  #   redirect_to gamme_path
  #   # @new_replace_product.shop = @shop
  # end
