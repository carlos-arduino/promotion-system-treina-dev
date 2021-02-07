require 'rails_helper'

feature 'Admin can inactivate a coupon' do
    scenario 'successfully' do
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                     description: 'Promoção de Cyber Monday',
                                     code: 'CYBER15', discount_rate: 15,
                                     expiration_date: '22/12/2033')
        coupon_active = Coupon.create!(code: 'CYBER15-0022', promotion: promotion)
        coupon_inactive = Coupon.create!(code: 'CYBER15-0023', promotion: promotion, status: :inactive)

        visit root_path
        click_on 'Promoções'
        click_on promotion.name
        page.find("#coupon-#{coupon_inactive.id}").click_on 'Inativar'

        coupon_inactive.reload

        expect(page).to have_content('CYBER15-0023 (Inativo)')
        expect(coupon_inactive).to be_inactive
    end

    scenario 'disable button Inativar for a inactive coupon' do
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                      description: 'Promoção de Cyber Monday',
                                      code: 'CYBER15', discount_rate: 15,
                                      expiration_date: '22/12/2033')
        coupon_active = Coupon.create!(code: 'CYBER15-0022', promotion: promotion)
        coupon_inactive = Coupon.create!(code: 'CYBER15-0023', promotion: promotion, status: :inactive)

        visit promotion_path(promotion)

        
        expect(page.find("#coupon-#{coupon_inactive.id}")).to_not have_content('Inativar')
        expect(page.find("#coupon-#{coupon_active.id}")).to have_content('Inativar')
    end
end