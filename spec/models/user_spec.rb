require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.new(name: "Roger", email: "AlsoRoger@roger.com")}
  
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
  end

  describe 'instance methods' do
    describe '#generate_api_key' do
      it 'returns a random string length 20' do
        key = user.generate_api_key

        expect(key).to be_a(String)
        expect(key.length).to eq(20)
      end
    end

    describe '#assign_api_key' do
      it 'updates a user api key' do
        expect(user.api_key).to be nil

        user.assign_api_key

        expect(user.api_key).not_to be nil
        expect(user.api_key).to be_a String
      end
    end
  end
end