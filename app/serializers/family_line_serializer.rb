# FamilyLineクラスのシリアライザ
class FamilyLineSerializer
  include JSONAPI::Serializer
  attributes :display_name, :family_number, :imported_by, :imported_at, :from

  attributes :bloodmare do |obj|
    HorseSerializer.new(obj.bloodmare).serializable_hash.fetch(:data, {})
  end

  attributes :horses do |obj|
    options = { fields: { horse: %i[display_name foaled sex group sire dam won_races] } }
    HorseSerializer.new(obj.horses, options).serializable_hash.fetch(:data, {})
  end
end
