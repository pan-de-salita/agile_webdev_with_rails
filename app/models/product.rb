# == Schema Information
#
# id         :integer         not null
# title      :string         
# description :text           
# image_url  :string         
# price      :decimal        
# created_at :datetime        not null
# updated_at :datetime        not null
# ==
class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\z/i,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, length: { minimum: 10 }

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, 'Line Items present')
    throw :abort
  end
end
