# 重賞
class GradedRace < ApplicationRecord
  belongs_to :grade
  has_many :major_wins, dependent: :restrict_with_exception
  has_many :horses, through: :major_wins

  delegate :name, :code, :rank, to: :grade, prefix: true

  enum :breed, %i[thoroughbred anglo_arab trotter banei]
  enum :status, %i[current former abolished]
end
