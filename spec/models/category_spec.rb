require 'rails_helper'

describe Category do
  context 'validation' do
    [:name, :code].each do |field|
      it { should validate_presence_of(field).with_message('não pode ficar em branco') }
    end
   
    it { should validate_uniqueness_of(:code).case_insensitive.with_message('já está em uso') }
  end
end
