require 'rails_helper'

feature 'Admin can inactivate a coupon' do
    scenario 'successfully' do
        user = User.create!(email: 'cae@email.com', password: '123456')
        login_as user, scope: :user
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                     description: 'Promoção de Cyber Monday',
                                     code: 'CYBER15', discount_rate: 15,
                                     expiration_date: '22/12/2033', user: user)
        coupon_active = Coupon.create!(code: 'CYBER15-0022', promotion: promotion)

        visit root_path
        click_on 'Promoções'
        click_on promotion.name
        page.find("#coupon-#{coupon_active.id}").click_on 'Inativar'

        coupon_active.reload

        expect(page).to have_content('CYBER15-0022 (Inativo)')
        expect(coupon_active).to be_inactive
    end

    scenario 'disable button Inativar for a inactive coupon' do
        user = User.create!(email: 'cae@email.com', password: '123456')
        login_as user, scope: :user
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                      description: 'Promoção de Cyber Monday',
                                      code: 'CYBER15', discount_rate: 15,
                                      expiration_date: '22/12/2033', user: user)
        coupon_active = Coupon.create!(code: 'CYBER15-0022', promotion: promotion)
        coupon_inactive = Coupon.create!(code: 'CYBER15-0023', promotion: promotion, status: :inactive)

        visit promotion_path(promotion)

        expect(page.find("#coupon-#{coupon_inactive.id}")).to_not have_content('Inativar')
        expect(page.find("#coupon-#{coupon_active.id}")).to have_content('Inativar')
    end
end