class LearningResourceSerializer
  include JSONAPI::Serializer
  attributes :id, :country, :video, :images
end
