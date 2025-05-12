class PayType < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, uniqueness: true
end
