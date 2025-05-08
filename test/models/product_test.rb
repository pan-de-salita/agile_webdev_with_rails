require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # fixtures :products

  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'product price must be positive' do
    product = Product.new(title: 'My Book Title',
                          description: 'yyy',
                          image_url: 'zzz.jpg')
    price_error = 'must be greater than or equal to 0.01'

    product.price = -1
    assert product.invalid?
    assert_equal [price_error], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal [price_error], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: 'My Book Title',
                description: 'yyy',
                price: 1,
                image_url: image_url)
  end

  test 'image_url' do
    ok = %w[fred.gif fred.jpg fred.png FRED.JPG fred.Jpg http://a.b.c/x/y/z/fred.gif]
    bad = %w[fred.doc fred.gif/more fred.gif.more]

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} must be valid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} must be invalid"
    end
  end

  test 'product is not valid without a unique title' do
    product = Product.new(title: products(:ruby).title,
                          description: 'yyy',
                          price: 1,
                          image_url: 'fred.gif')
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end

  test 'product title must be at least 10 characters long' do
    ok = ['A Long-Enough Title', 'Agile Web Development with Rails']
    bad = ['c', 'c++', 'c#']

    ok.each do |title|
      product = Product.new(title: title,
                            description: 'yyy',
                            price: 1,
                            image_url: 'test.jpg')
      assert product.valid?, "#{title} must be valid"
    end

    bad.each do |title|
      product = Product.new(title: title,
                            description: 'yyy',
                            price: 1,
                            image_url: 'test.jpg')
      assert product.invalid?, "#{title} must be invalid"
    end
  end
end
