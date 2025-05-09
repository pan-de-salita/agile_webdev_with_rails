require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  test 'should get index' do
    get carts_url
    assert_response :success
  end

  test 'should get new' do
    get new_cart_url
    assert_response :success
  end

  test 'should create cart' do
    assert_difference('Cart.count') do
      post carts_url, params: { cart: {} }
    end

    assert_redirected_to cart_url(Cart.last)
  end

  test 'should show cart' do
    post line_items_url, params: { product_id: products(:one).id }

    get store_index_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_cart_url(@cart)
    assert_response :success
  end

  test 'should update cart' do
    patch cart_url(@cart), params: { cart: {} }
    assert_redirected_to cart_url(@cart)
  end

  test 'should destroy cart' do
    post line_items_url, params: { product_id: products(:ruby).id }
    @cart = Cart.find(session[:cart_id])

    assert_difference('Cart.count', -1) do
      delete cart_url(@cart)
    end

    assert_redirected_to store_index_url
  end

  test 'should add unique products to cart' do
    post line_items_url, params: { product_id: products(:one).id }
    post line_items_url, params: { product_id: products(:two).id }
    post line_items_url, params: { product_id: products(:ruby).id }
    @cart = Cart.find(session[:cart_id])

    assert_equal @cart.line_items.length, 3
    @cart.line_items.each { |line_item| assert_equal line_item.quantity, 1 }
    assert_redirected_to store_index_url
  end

  test 'should add duplicate products to cart' do
    post line_items_url, params: { product_id: products(:ruby).id }
    post line_items_url, params: { product_id: products(:ruby).id }
    post line_items_url, params: { product_id: products(:ruby).id }
    @cart = Cart.find(session[:cart_id])

    assert_equal @cart.line_items.length, 1
    assert_equal @cart.line_items.first.quantity, 3
    assert_redirected_to store_index_url
  end
end
