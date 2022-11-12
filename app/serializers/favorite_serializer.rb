class FavoriteSerializer
  include JSONAPI::Serializer
  attributes :id, :recipe_title, :recipe_link, :country, :created_at
end
