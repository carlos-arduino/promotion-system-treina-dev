require 'rails_helper'

feature 'admin can approve a promotion' do
    scenario 'should be sign in' do
        user = User.create!(email: 'cae@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                      description: 'Promoção de Cyber Monday',
                                      code: 'CYBER15', discount_rate: 15,
                                      expiration_date: '22/12/2033', user: user)
        
        visit root_path
        click_on 'Promoções'
        
        expect(current_path).to eq new_user_session_path
    end

    scenario 'and should not be promotion creator' do
        creator = User.create!(email: 'cae@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                      description: 'Promoção de Cyber Monday',
                                      code: 'CYBER15', discount_rate: 15,
                                      expiration_date: '22/12/2033', user: creator)
        
        login_as creator, scope: :user
        visit promotion_path(promotion)
        
        expect(page).not_to have_link 'Aprovar Promoção'
    end

    scenario 'successfully' do
        creator = User.create!(email: 'cae@email.com', password: '123456')
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                      description: 'Promoção de Cyber Monday',
                                      code: 'CYBER15', discount_rate: 15,
                                      expiration_date: '22/12/2033', user: creator)
        approval_user = User.create!(email: 'eduardo@email.com', password: '123456')

        login_as approval_user, scope: :user
        visit promotion_path(promotion)
        click_on 'Aprovar Promoção'

        promotion.reload
        expect(current_path).to eq promotion_path(promotion)
        expect(promotion.approved?).to be_truthy
        expect(promotion.approver).to eq approval_user
        expect(page).to have_content 'Status: Aprovada'
    end


end