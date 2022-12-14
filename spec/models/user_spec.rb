require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  
  describe 'relationships' do
    it { should have_many :favorites }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password}
    it { should have_secure_password }
  end

  describe 'class methods' do 
    describe '::generate_api_key' do
      it 'returns a random string length 20' do
        key = User.generate_api_key
  
        expect(key).to be_a(String)
        expect(key.length).to eq(20)
      end
    end

    describe '::unique_key' do
      it 'checks that a generated key is not already present in database' do
        
      end
    end
  end

  describe 'instance methods' do
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