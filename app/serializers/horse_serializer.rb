# Horseクラスのシリアライザ
class HorseSerializer
  include JSONAPI::Serializer
  belongs_to :sire, serializer: :horse, if: proc { |obj| obj.race_horse? }
  belongs_to :dam, serializer: :horse, if: proc { |obj| obj.race_horse? }

  belongs_to :family_line

  has_many :major_wins
  has_many :awardings

  attributes :name, :pedigree_name, :foaled, :sex, :breed, :group

  attribute :won_races do |obj|
    major_wins = obj.major_wins
    major_wins.sort_by(&:date).each_with_object(Hash.new([])) do |w, h|
      h[w.date.year] += [w.name]
    end
  end

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
end
