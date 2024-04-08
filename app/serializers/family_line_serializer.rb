# FamilyLineクラスのシリアライザ
class FamilyLineSerializer
  include JSONAPI::Serializer
  has_many :horses
  belongs_to :bloodmare, record_type: :horse, serializer: :horse

  attributes :display_name, :family_number, :imported_by, :imported_at, :from
end
