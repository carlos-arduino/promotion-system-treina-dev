require 'rails_helper'

feature 'Admin can generate coupons' do
    scenario 'associated with promotion' do
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                          description: 'Promoção de Cyber Monday',
                          code: 'CYBER15', discount_rate: 15,
                          expiration_date: '22/12/2033')

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
end