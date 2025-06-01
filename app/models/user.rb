# == Schema Information
#
# id         :integer         not null
# name       :string
# password_digest :string
# created_at :datetime        not null
# updated_at :datetime        not null
# ==
class User < ApplicationRecord
  has_secure_password

  validates :name, :password, presence: true
  validates :name, uniqueness: true
end
