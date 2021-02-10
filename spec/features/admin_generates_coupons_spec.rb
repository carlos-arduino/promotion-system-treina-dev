require 'rails_helper'

feature 'Admin generate coupons' do
    scenario 'associated with promotion' do
        user = User.create!(email: 'cae@email.com', password: '123456')
        another_user = User.create!(email: 'eduardo@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                          description: 'Promoção de Cyber Monday',
                          code: 'CYBER15', discount_rate: 15,
                          expiration_date: '22/12/2033', user: user)
        PromotionApproval.create!(promotion: promotion, user: another_user)

        login_as user, scope: :user

        visit root_path
        click_on 'Promoções'
        click_on promotion.name
        click_on 'Gerar Cupons'

        expect(page).to have_content('Cupons gerados com sucesso')
        expect(page).to have_content('CYBER15-0001')
        expect(page).to have_content('CYBER15-0002')
        expect(page).to have_content('CYBER15-0100')
        expect(page).not_to have_content('CYBER15-0101')
        expect(current_path).to eq(promotion_path(promotion))
    end

    scenario 'unsuccessfully with promotion no approved' do
        user = User.create!(email: 'cae@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                          description: 'Promoção de Cyber Monday',
                          code: 'CYBER15', discount_rate: 15,
                          expiration_date: '22/12/2033', user: user)

        login_as user, scope: :user
        visit promotion_path(promotion)

        expect(page).not_to have_link('Gerar Cupons')
    end
end