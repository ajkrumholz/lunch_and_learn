class User < ApplicationRecord
  validates_presence_of :name, :email

  def assign_api_key
    update(api_key: generate_api_key)
  end

  def generate_api_key
    characters = (0..9).to_a + ('a'..'z').to_a
    characters.sample(20).join
  end
end