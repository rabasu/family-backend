# MajorWinクラスのシリアライザ
class MajorWinSerializer
  include JSONAPI::Serializer
  belongs_to :horse
  attributes :date, :code, :name, :official_name, :desc, :grade_name, :grade_rank, :grade_code
end
