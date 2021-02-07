class CouponsController < ApplicationController
    def disable
        @coupon = Coupon.find(params[:id])
        @coupon.inactive!

        redirect_to @coupon.promotion, notice: "#{@coupon.code} (Inativo)"
    end
end