# Horseクラスのシリアライザ
class HorseSerializer
  include JSONAPI::Serializer
  # belongs_to :sire, include_data: true, serializer: :horse, if: proc { |obj| obj.race_horse? }
  # belongs_to :dam, record_type: :horse, serializer: :horse, if: proc { |obj| obj.race_horse? }

  # belongs_to :family_line, if: proc { |obj| obj.race_horse? || obj.imported_mare? }

  # has_many :awardings, if: proc { |obj| obj.race_horse? }
  attribute :display_name do |obj|
    name = obj.name
    p_name = obj.pedigree_name

    if name && p_name
      "#{p_name}：#{name}"
    elsif name.blank?
      p_name.to_s
    else
      name.to_s
    end
  end

  attributes :foaled, :sex, :breed, :group

  attributes :sire, if: proc { |obj| obj.race_horse? } do |obj|
    HorseSerializer.new(obj.sire).serializable_hash.fetch(:data, {})
  end

  attributes :dam, if: proc { |obj| obj.race_horse? } do |obj|
    HorseSerializer.new(obj.dam).serializable_hash.fetch(:data, {})
  end

  attributes :family_line, if: proc { |obj| obj.race_horse? || obj.imported_mare? } do |obj|
    options = { fields: { family_line: %i[display_name family_number imported_at imported_by] } }
    FamilyLineSerializer.new(obj.family_line, options).serializable_hash.fetch(:data, {})
  end

  attributes :awardings, if: proc { |obj| obj.race_horse? } do |obj|
    AwardingSerializer.new(obj.awardings).serializable_hash.fetch(:data, {})
  end

  attribute :won_races do |obj|
    major_wins = obj.major_wins
    major_wins.sort_by(&:date).each_with_object(Hash.new([])) do |w, h|
      h[w.date.year] += [w.name]
    end
  end
end
