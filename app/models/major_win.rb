class MajorWin < ApplicationRecord
  belongs_to :horse
  belongs_to :graded_race

  delegate :name, to: :graded_race

  delegate :official_name, to: :graded_race
end
