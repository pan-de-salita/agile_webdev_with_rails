require "test_helper"

class ErrorMailerTest < ActionMailer::TestCase
  test "invalid_cart" do
    mail = ErrorMailer.invalid_cart
    assert_equal "Invalid cart", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
