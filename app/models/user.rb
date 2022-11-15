class User < ApplicationRecord
  has_many :favorites
  has_secure_password

  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email

  

  def self.find_by_key(api_key)
    User.find_by(api_key: api_key)
  end

  def assign_api_key
    update(api_key: User.unique_key)
  end

  def self.generate_api_key
    characters = (0..9).to_a + ('a'..'z').to_a
    characters.sample(20).join
  end

  def self.unique_key
    api_key = generate_api_key
    until find_by_key(api_key).nil?
      api_key = generate_api_key
    end
    api_key
  end
end