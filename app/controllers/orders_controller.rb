class OrdersController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_isnt_empty, only: %i[new]
  before_action :process_params, only: %i[create update]
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    puts @processed_params
    @order = Order.new(@processed_params)
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        format.html { redirect_to store_index_url, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(@processed_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_path, status: :see_other, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end

  def ensure_cart_isnt_empty
    return unless @cart.line_items.empty?

    redirect_to store_index_url, notice: 'Your cart is empty'
  end

  # def process_params
  #   @processed_params = order_params
  #                       .except(:pay_type)
  #                       .merge!({ pay_type_id: PayType.find_by!(name: order_params[:pay_type]).id })
  # end

  def process_params
    pay_type_name = order_params[:pay_type]
    pay_type = PayType.find_by(name: pay_type_name)

    raise ActiveRecord::RecordNotFound, "Pay type '#{pay_type_name}' not found" unless pay_type

    @processed_params = order_params.except(:pay_type).merge(pay_type_id: pay_type.id)
  end
end
