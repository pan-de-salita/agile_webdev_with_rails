class StoreController < ApplicationController
  include CurrentCart
  include StoreVisitCount

  skip_before_action :authorize

  before_action :set_cart, only: %i[index]
  before_action :set_store_visit_count, only: %i[index]

  def index
    @products = if params[:search].present?
                  Product.all.select { |product| product.title.downcase.include?(params[:search]) }
                else
                  Product.order(:title)
                end

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
