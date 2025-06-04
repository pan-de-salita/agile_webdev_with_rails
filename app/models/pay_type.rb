# == Schema Information
#
# id         :integer         not null
# name       :string
# created_at :datetime        not null
# updated_at :datetime        not null
# ==
class PayType < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, uniqueness: true
end
