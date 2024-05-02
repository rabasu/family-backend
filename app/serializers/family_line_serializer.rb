# FamilyLineクラスのシリアライザ
class FamilyLineSerializer
  include JSONAPI::Serializer
  attributes :pedigree_name, :family_number, :imported_by, :from

  attributes :imported_year do |obj|
    obj.imported_at.year
  end

  attributes :bloodmare do |obj|
    options = { fields: { horse: %i[display_name foaled_year won_races] } }
    HorseSerializer.new(obj.bloodmare, options).serializable_hash.fetch(:data, {})
  end

  attributes :horses do |obj|
    options = { fields: { horse: %i[display_name foaled sex group sire_name dam_name won_races] } }
    HorseSerializer.new(obj.horses, options).serializable_hash.fetch(:data, {})
  end
end
