# Horseクラスのシリアライザ
class HorseSerializer
  include JSONAPI::Serializer
  # belongs_to :sire, include_data: true, serializer: :horse, if: proc { |obj| obj.race_horse? }
  # belongs_to :dam, record_type: :horse, serializer: :horse, if: proc { |obj| obj.race_horse? }

  # belongs_to :family_line, if: proc { |obj| obj.race_horse? || obj.imported_mare? }

  # has_many :awardings, if: proc { |obj| obj.race_horse? }

  attributes :display_name, :foaled, :sex, :breed, :group

  attributes :foaled_year do |obj|
    obj.foaled&.year
  end

  attributes :sire, if: proc { |obj| obj.race_horse? } do |obj|
    options = { fields: { horse: %i[display_name foaled won_races all_races family_line] } }
    HorseSerializer.new(obj.sire, options).serializable_hash.fetch(:data, {})
  end

  attributes :sire_name, if: proc { |obj| obj.race_horse? } do |obj|
    obj.sire&.display_name
  end

  attributes :dam, if: proc { |obj| obj.race_horse? } do |obj|
    options = { fields: { horse: %i[display_name foaled won_races all_races family_line] } }
    HorseSerializer.new(obj.dam, options).serializable_hash.fetch(:data, {})
  end

  attributes :dam_name, if: proc { |obj| obj.race_horse? } do |obj|
    obj.dam&.display_name
  end

  attributes :family_line, if: proc { |obj| obj.race_horse? || obj.imported_mare? } do |obj|
    options = { fields: { family_line: %i[pedigree_name family_number imported_at imported_by] } }
    FamilyLineSerializer.new(obj.family_line, options).serializable_hash.fetch(:data, {})
  end

  attributes :awardings, if: proc { |obj| obj.race_horse? } do |obj|
    AwardingSerializer.new(obj.awardings).serializable_hash.fetch(:data, {})
  end

  # k=年, v=勝利競走の配列でHashを生成する
  attribute :won_races do |obj|
    racing_records = obj.racing_records.select { |r| r.finnish == 1 }
    racing_records.sort_by(&:date).each_with_object(Hash.new([])) do |w, h|
      h[w.date.year] += [w.name]
    end
  end

  # 勝利以外のレコードを含めてHashを生成する
  attributes :all_races do |obj|
    racing_records = obj.racing_records.sort_by(&:date)
    racing_records.each_with_object(Hash.new([])) do |r, h|
      record = { finnish: r.finnish, name: r.name }
      h[r.date.year] += [record]
    end
  end
end
