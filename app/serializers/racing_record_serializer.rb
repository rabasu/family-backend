# RacingRecordクラスのシリアライザ
class RacingRecordSerializer
  include JSONAPI::Serializer
  belongs_to :horse
  attributes :date, :code, :name, :official_name, :finnish, :desc, :grade_name, :grade_rank, :grade_code
end
