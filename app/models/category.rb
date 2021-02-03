class Category < ApplicationRecord
    validates :name, :code, presence: true
    validates :code, uniqueness: { case_sensitive: false }
end
