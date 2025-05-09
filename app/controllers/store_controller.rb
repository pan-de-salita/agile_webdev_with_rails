class StoreController < ApplicationController
  include CurrentCart
  include StoreVisitCount

  before_action :set_cart, only: %i[index]
  before_action :set_store_visit_count, only: %i[index]

  def index
    @products = Product.order(:title)
  end
end
