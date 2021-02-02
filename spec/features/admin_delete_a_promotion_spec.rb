require 'rails_helper'

feature 'Admin delete a promotion' do
    scenario 'from index page' do
        Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
            description: 'Promoção de Cyber Monday',
            code: 'CYBER15', discount_rate: 15,
            expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Cyber Monday'
        click_on 'Apagar'

        expect(page).to have_content('Nenhuma promoção cadastrada')
    end

end