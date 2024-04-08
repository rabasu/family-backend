# Awardingクラスのシリアライザ
class AwardingSerializer
  include JSONAPI::Serializer
  belongs_to :horse
  attributes :year, :name, :desc
end
