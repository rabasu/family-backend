class Award < ApplicationRecord
  has_many :awardings, dependent: :destroy
end
