# 牝系
class FamilyLine < ApplicationRecord
  has_many :horses, dependent: :restrict_with_exception
  belongs_to :bloodmare, class_name: 'Horse'
  delegate :display_name, to: :bloodmare

  enum :from, %i[America England Ireland Australia NewZealand]

  def self.generate(**attr)
    family = FamilyLine.find_or_create_by(bloodmare_id: attr[:bloodmare].id)
    family.update(attr)
    family
  end
end
