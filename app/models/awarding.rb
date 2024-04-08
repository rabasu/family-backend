# 受賞馬とその賞、および受賞年
class Awarding < ApplicationRecord
  belongs_to :horse
  belongs_to :award

  delegate :name, :desc, to: :award
end
