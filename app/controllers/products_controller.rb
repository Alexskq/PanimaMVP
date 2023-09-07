class ProductsController < ApplicationController

  def index
    @products = Product.all
    if params[:query].present?
      search_query = params[:query].capitalize
      @products = Product.where("products.name ilike :query or products.ean ilike :query", query: "%#{search_query}%")
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "products/list", locals: {products: @products}, formats: [:html] }
    end
  end
end
