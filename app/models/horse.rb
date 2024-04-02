class Horse < ApplicationRecord
  belongs_to :sire, class_name: 'Horse', optional: true
  belongs_to :dam, class_name: 'Horse', optional: true
  has_many :sire_foals, class_name: 'Horse', foreign_key: 'sire_id', dependent: :restrict_with_exception, inverse_of: 'sire'
  has_many :dam_foals, class_name: 'Horse', foreign_key: 'dam_id', dependent: :restrict_with_exception, inverse_of: 'dam'

  belongs_to :family_line, optional: true
  has_one :her_family, class_name: 'FamilyLine', foreign_key: 'bloodmare_id', dependent: :restrict_with_exception, inverse_of: 'bloodmare'
  has_one :bloodmare, class_name: 'Horse', through: :family_line

  has_many :major_wins, dependent: :destroy
  has_many :graded_races, through: :major_wins

  has_many :awardings, dependent: :destroy

  enum :sex, [ :male, :female ]
  enum :breed, [ :thoroughbred, :anglo_arab, :sara_kei, :ara_kei, :arab, :keihan, :chuhan, :trotter ]
  enum :group, [ :race_horse, :imported_mare, :stub ]

  # 馬の特定には name(競走名)とfoaled(生年月日)を用いる
  # stub(血統表用の仮モデル)であってもfoaledは必須とする
  # ただし、imported_mareの生成時のみfoaled無しを許容する(name単体で特定可能なため)
  # FamilyLineはあくまで仮置きであり、後々詳細を追加する前提
  # def self.generate(name:, pedigree_name:, foaled:, sex:, breed: :thoroughbred, group: :race_horse, family:, only_year: false)
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

  # 名前からimported_mare(輸入牝馬)を生成する
  def self.generate_imported_mare(**attr)
    defaults = { sex: :female, breed: :thoroughbred, group: :imported_mare, only_year: true }
    Horse.generate(**defaults.merge(attr))
  end

  # 競走馬を競走名・生年月日・性別・牝系（・繁殖名・品種）から生成する
  def self.generate_race_horse(**attr)
    defaults = { breed: :thoroughbred, group: :race_horse, only_year: false }
    Horse.generate(**defaults.merge(attr))
  end

  # 血統表に設定するためのstubを生成する
  # race_horseが存在するならそれを使用する
  def self.generate_stub(**attr)
    defaults = { breed: :thoroughbred, group: :stub, only_year: false }
    Horse.generate(**defaults.merge(attr))
  end

  def win(date:, race_name:, code:, status: :current)
    race = GradedRace.find_by(
      official_name: race_name,
      status: status,
      grade: Grade.find_by(code: code),
    )
    MajorWin.create(
      date: date&.to_date,
      horse: self,
      graded_race: race,
    )
  end

  def display_name
    name = self.name
    p_name = pedigree_name

    if name && p_name
      "#{p_name}：#{name}"
    elsif name.blank?
      p_name.to_s
    else
      name.to_s
    end
  end

  # k=年, v=勝利競走の配列でHashを生成する
  def won_races
    major_wins = self.major_wins
    major_wins.sort_by(&:date).each_with_object(Hash.new([])) do |w, h|
      h[w.date.year] += [w.name]
    end
  end
end
