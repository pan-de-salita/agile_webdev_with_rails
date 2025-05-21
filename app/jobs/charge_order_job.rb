# The purpose of job classes like ChargeOrderJob is to act as a glue between the controller -- which
# wants to run some logic later -- and the actual logic in the models.
#
class ChargeOrderJob < ApplicationJob
  queue_as :default

  # User
  # |
  # A. OrdersController
  # - Save Order
  # - Start Background Job ---> B
  # - Render "Thank You"
  # B. ChargeOrderJob
  # - Call Order.charge! ---> C
  # C. Order
  # - Call Pago
  # - Send Email

  def perform(order, pay_type_params)
    order.charge!(pay_type_params)
  end
end
