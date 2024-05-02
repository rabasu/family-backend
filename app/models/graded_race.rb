# 重賞
class GradedRace < ApplicationRecord
  belongs_to :grade
  has_many :racing_records, dependent: :restrict_with_exception
  has_many :horses, through: :racing_records

  delegate :name, :code, :rank, to: :grade, prefix: true

  enum :breed, %i[thoroughbred anglo_arab trotter banei]
  enum :status, %i[current former abolished]
end
