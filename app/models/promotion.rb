class Promotion < ApplicationRecord
    has_many :coupons

    validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: true
    validates :code , uniqueness: { message: "deve ser único" } 

    def generate_coupons!
        Coupon.transaction do
            coupons.insert_all!(mount_coupons_array)
        end
    end

    private

    def mount_coupons_array
        1.upto(coupon_quantity).inject([]) do |arr, number|
            arr << { code: "#{code}-#{'%04d' % number}", 
                     created_at: Time.now,
                     updated_at: Time.now }
        end
    end
end
