class StoreController < ApplicationController
  include CurrentCart
  include StoreVisitCount

  before_action :set_cart, only: %i[index]
  before_action :set_store_visit_count, only: %i[index]

  def index
    @products = Product.order(:title)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'store_visit_count',
          partial: 'store_visit_count',
          locals: { store_visit_count: @store_visit_count }
        )
      end

      format.html
      format.json
    end
  end
end
