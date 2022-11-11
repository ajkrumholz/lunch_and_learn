class RecipeSerializer
  include JSONAPI::Serializer
  attributes :title, :url, :image, :country
end
