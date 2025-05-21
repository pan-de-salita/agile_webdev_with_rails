class ErrorMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_mailer.invalid_cart.subject
  #
  def invalid_cart(invalid_id)
    @invalid_cart_id = invalid_id

    mail to: 'admin@depot.com', subject: "Attempt to access invalid cart #{@invalid_cart_id}"
  end
end
