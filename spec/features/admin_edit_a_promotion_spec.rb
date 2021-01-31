require 'rails_helper'

feature 'Admin edit a promotion' do
    scenario 'from index page' do
        Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                          description: 'Promoção de Cyber Monday',
                          code: 'CYBER15', discount_rate: 15,
                          expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Cyber Monday'

        expect(page).to have_link('Editar')
    end

    scenario 'and show all form fields from edit promotion view' do
        Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
            description: 'Promoção de Cyber Monday',
            code: 'CYBER15', discount_rate: 15,
            expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Cyber Monday'
        click_on 'Editar'
        
        expect(page).to have_field('Nome')
        expect(page).to have_field('Descrição')
        expect(page).to have_field('Código')
        expect(page).to have_field('Desconto')
        expect(page).to have_field('Quantidade de cupons')
        expect(page).to have_field('Data de término')
    end

    scenario 'can edit any field' do
        Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
            description: 'Promoção de Cyber Monday',
            code: 'CYBER15', discount_rate: 15,
            expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Cyber Monday'
        click_on 'Editar'

        fill_in 'Nome', with: 'Cyber Thursday'
        fill_in 'Descrição', with: 'Promoção de Cyber Thursday'
        fill_in 'Quantidade de cupons', with: '20'
        fill_in 'Código', with: 'CYBER20'
        fill_in 'Desconto', with: '20'
        fill_in 'Data de término', with: '22/12/2030'

        click_on 'Atualizar Promoção'
        
        expect(page).to have_content('Cyber Thursday')
        expect(page).to have_content('Promoção de Cyber Thursday')
        expect(page).to have_content('CYBER20')
        expect(page).to have_content('20')
        expect(page).to have_content('20')
        expect(page).to have_content('22/12/2030')

        expect(current_path).to eq(promotion_path(Promotion.last)) 
    end

    scenario 'and not show old values fields previously edited' do
        Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
            description: 'Promoção de Cyber Monday',
            code: 'CYBER15', discount_rate: 15,
            expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Cyber Monday'
        click_on 'Editar'

        fill_in 'Nome', with: 'Cyber Thursday'
        fill_in 'Descrição', with: 'Promoção de Cyber Thursday'
        fill_in 'Quantidade de cupons', with: '20'
        fill_in 'Código', with: 'CYBER20'
        fill_in 'Desconto', with: '20'
        fill_in 'Data de término', with: '22/12/2030'

        click_on 'Atualizar Promoção'
        
        expect(page).not_to have_content('Cyber Monday')
        expect(page).not_to have_content('Promoção de Cyber Monday')
        expect(page).not_to have_content('CYBER15')
        expect(page).not_to have_content('100')
        expect(page).not_to have_content('15')
        expect(page).not_to have_content('22/12/2033')

        expect(current_path).to eq(promotion_path(Promotion.last))
    end
end