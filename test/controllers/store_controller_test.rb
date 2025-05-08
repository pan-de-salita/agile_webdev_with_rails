require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  fixtures :products

  test 'should get index' do
    get store_index_url
    assert_response :success
    assert_select 'nav a', minimum: 4
    assert_select 'main ul li', products.size
    assert_select 'h2', 'Programming Ruby 1.9'
    assert_select 'div', /\$[,\d]+\.\d\d/
  end
end
