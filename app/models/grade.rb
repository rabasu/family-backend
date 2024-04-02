# 重賞格付け
class Grade < ApplicationRecord
  has_many :graded_races, dependent: :restrict_with_exception
end
