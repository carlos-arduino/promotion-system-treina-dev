class Coupon < ApplicationRecord
  belongs_to :promotion

  validates :code , uniqueness: true
end
