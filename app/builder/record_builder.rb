class RecordBuilder < Builder
  def build(**attributes)
    defaults = { breed: :thoroughbred, group: :race_horse, only_year: false }

    attr = defaults.merge(attributes)
    attr[:foaled] = datify(attr[:foaled], only_year: attr[:only_year])

    # 1: family_lineを馬名としてHorseを検索・生成する
    bloodmare = Horse.generate_imported_mare(pedigree_name: attr[:family_line])
    # 2: 上結果を用いてFamilyLineを検索・生成する
    family_line = FamilyLine.generate(bloodmare: bloodmare)
    # 3: 上結果を用いてattr[:family_line]をFamily_lineモデルで設定する
    attr[:family_line] = family_line

    Horse.generate(**attr)
  end

  def build_family(**attributes)
    defaults = { only_year: true }

    attr = defaults.merge(attributes)
    attr[:imported_at] = datify(attr[:imported_at], only_year: attr[:only_year])
    attr[:foaled] = datify(attr[:foaled], only_year: attr[:foaled_only_year])

    bloodmare = Horse.generate_imported_mare(
      pedigree_name: attr[:bloodmare],
      foaled: attr[:foaled],
      only_year: attr[:foaled_only_year],
    )
    attr[:bloodmare] = bloodmare

    columns = [:bloodmare, :family_number, :imported_by, :imported_at, :only_year, :from]
    FamilyLine.generate(**attr.slice(*columns))
  end

  def win(horse:, date:, race_name:, code:, status: :current)
    race = GradedRace.find_by(
      official_name: race_name,
      status: status,
      grade_id: Grade.find_by(code: code).id,
    )
    MajorWin.create(
      date: datify(date),
      horse: horse,
      graded_race: race,
    )
  end
end
