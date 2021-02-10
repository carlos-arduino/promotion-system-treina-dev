require 'rails_helper'

RSpec.describe PromotionApproval, type: :model do
  context 'validation' do
    it 'User approver must be different' do
      creator = User.create!(email: 'cae@email.com', password: '123456')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10,
                                    coupon_quantity: 100, expiration_date: '22/12/2033', user: creator)
      promotion_approval = PromotionApproval.new(promotion: promotion, user: creator)

      result = promotion_approval.valid?

      expect(result).to eq(false)
      expect(promotion_approval.errors[:user]).to include('Criador e aprovador precisam ser diferentes')
    end

    it 'with no promotion or user' do
      promotion_approval = PromotionApproval.new()
      
      expect(promotion_approval.valid?).to eq(false)
    end

    it 'successfully' do
      creator = User.create!(email: 'cae@email.com', password: '123456')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10,
                                    coupon_quantity: 100, expiration_date: '22/12/2033', user: creator)
      promotion_approver = User.create!(email: 'eduardo@email.com', password: '123456')
      promotion_approval = PromotionApproval.new(promotion: promotion, user: promotion_approver)

      expect(promotion_approval.valid?).to eq(true)
    end      
  end
end
