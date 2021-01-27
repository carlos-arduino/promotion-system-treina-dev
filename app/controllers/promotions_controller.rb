class PromotionsController < ApplicationController
    def index
        @promotions = Promotion.all
        if @promotions.count == 0
            flash.now[:alert] = "Nenhuma promoção cadastrada"            
        end
    end

    def show
        @promotion = Promotion.find(params[:id])
    end
end