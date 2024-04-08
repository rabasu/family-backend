# 重賞勝ち鞍
class MajorWin < ApplicationRecord
  belongs_to :horse
  belongs_to :graded_race

  delegate :code, :name, :official_name, :desc, :grade_name, :grade_code, :grade_rank, to: :graded_race
end
