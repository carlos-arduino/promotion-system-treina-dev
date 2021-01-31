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

    def new
        @promotion = Promotion.new
    end

    def create
        @promotion = Promotion.new(promotion_params)

        if @promotion.save 
            redirect_to @promotion
        else 
            render :new 
        end
    end

    def edit 
        @promotion = Promotion.find(params[:id])
    end

    def update
        @promotion = Promotion.find(params[:id])
        
        if @promotion.update(promotion_params)
            redirect_to @promotion
        else
            render :edit
        end
    end

    private
    def promotion_params
        params.require(:promotion)
              .permit(:name, :description, :code, :discount_rate, :coupon_quantity, :expiration_date)
    end
end