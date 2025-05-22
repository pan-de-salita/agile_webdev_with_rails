require 'test_helper'

class ErrorMailerTest < ActionMailer::TestCase
  test 'invalid_cart' do
    mail = ErrorMailer.invalid_cart('invalid')
    assert_equal 'Attempt to access invalid cart invalid', mail.subject
    assert_equal ['admin@depot.com'], mail.to
    assert_equal ['depot@example.com'], mail.from
    assert_match 'invalid', mail.body.encoded
  end
end
