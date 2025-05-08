class StoreController < ApplicationController
  include StoreVisitCount

  before_action :set_store_visit_count, only: %i[index]

  def index
    @products = Product.order(:title)
  end
end
