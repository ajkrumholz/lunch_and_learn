class User < ApplicationRecord
  has_many :favorites
  
  validates_presence_of :name, :email
  validates_uniqueness_of :email

  def assign_api_key
    update(api_key: generate_api_key)
  end

  def generate_api_key
    characters = (0..9).to_a + ('a'..'z').to_a
    characters.sample(20).join
  end
end