# 馬 競走馬・輸入牝馬・スタブ（血統表にのみ表示）の3種
class Horse < ApplicationRecord
  belongs_to :sire, class_name: 'Horse', optional: true
  belongs_to :dam, class_name: 'Horse', optional: true
  has_many :sire_foals, class_name: 'Horse', foreign_key: 'sire_id', dependent: :restrict_with_exception, inverse_of: 'sire'
  has_many :dam_foals, class_name: 'Horse', foreign_key: 'dam_id', dependent: :restrict_with_exception, inverse_of: 'dam'

  belongs_to :family_line, optional: true
  has_one :her_family, class_name: 'FamilyLine', foreign_key: 'bloodmare_id', dependent: :destroy, inverse_of: 'bloodmare'
  has_one :bloodmare, class_name: 'Horse', through: :family_line

  has_many :racing_records, dependent: :destroy
  has_many :graded_races, through: :racing_records

  has_many :awardings, dependent: :destroy

  enum :sex, %i[male female]
  enum :breed, %i[thoroughbred anglo_arab sara_kei ara_kei arab keihan chuhan trotter]
  enum :group, %i[race_horse imported_mare stub]

  # 馬の特定には name(競走名)とfoaled(生年月日)を用いる
  # stub(血統表用の仮モデル)であってもfoaledは必須とする
  # ただし、imported_mareの生成時のみfoaled無しを許容する(pedigree_name単体で特定可能なため)
  def self.generate(**attr)
    Rails.logger.info("Horse.generate: name=#{attr[:name]}, pedigree_name=#{attr[:pedigree_name]}, group=#{attr[:group]}")

    horse = if attr[:group] == :imported_mare
              Horse.find_or_create_by(pedigree_name: attr[:pedigree_name])
            else
              Horse.find_or_create_by(name: attr[:name], foaled: attr[:foaled])
            end
    horse.update(attr)
    horse
  end

  def self.generate_imported_mare(**attr)
    defaults = { sex: :female, breed: :thoroughbred, group: :imported_mare, only_year: true }
    Horse.generate(**defaults.merge(attr))
  end

  def self.generate_race_horse(**attr)
    defaults = { breed: :thoroughbred, group: :race_horse, only_year: false }
    Horse.generate(**defaults.merge(attr))
  end

  def self.generate_stub(**attr)
    defaults = { breed: :thoroughbred, group: :stub, only_year: false }
    Horse.generate(**defaults.merge(attr))
  end

  def display_name
    # name = self.name
    # p_name = pedigree_name

    if name && pedigree_name
      "#{pedigree_name}/#{name}"
    elsif name.blank?
      pedigree_name.to_s
    else
      name.to_s
    end
  end

  # 自身のfamily_lineのbloodmareのdisplay_nameを返す
  def bloodmare_display_name
    bloodmare&.display_name
  end
end
