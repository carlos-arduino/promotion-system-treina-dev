class PromotionApproval < ApplicationRecord
  belongs_to :user
  belongs_to :promotion

  validate :different_user

  private

  def different_user
    if promotion&.user == user
      errors.add(:user, 'Criador e aprovador precisam ser diferentes')
    end
  end
end
