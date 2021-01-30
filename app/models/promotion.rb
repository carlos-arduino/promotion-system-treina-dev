class Promotion < ApplicationRecord
    validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: true
    validates :code , uniqueness: { message: "deve ser único" } 
end
