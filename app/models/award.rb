# 各種受賞
class Award < ApplicationRecord
  has_many :awardings, dependent: :destroy
end
