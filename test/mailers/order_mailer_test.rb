require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  setup do
    @order = orders(:one)
    @order.line_items << line_items(:two)
  end

  test 'received' do
    mail = OrderMailer.received(@order)
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
    assert_equal ['dave@example.org'], mail.to
    assert_equal ['depot@example.com'], mail.from
    assert_match(/1 x Programming Ruby 1.9/, mail.body.encoded)
  end

  test 'shipped' do
    mail = OrderMailer.shipped(@order)
    assert_equal 'Pragmatic Store Order Shipped', mail.subject
    assert_equal ['dave@example.org'], mail.to
    assert_equal ['depot@example.com'], mail.from
    assert_match %r{<td\s+class="text-right">\s*1\s*</td>}m, mail.body.encoded
    assert_match %r{<td>&times;</td>}m, mail.body.encoded
    assert_match %r{<td\s+class="pr-2">\s*Programming\s+Ruby\s+1\.9\s*</td>}m, mail.body.encoded
  end
end
