# frozen_string_literal: true

class Add2024Winner < ActiveRecord::Migration[7.1]
  def up
    ActiveRecord::Base.transaction do
      rb = RecordBuilder.new
      # スウィープフィート
      sweepfeet = rb.build(
        name: 'スウィープフィート',
        foaled: '2021/04/05',
        sex: :female,
        group: :race_horse,
        family_line: 'セヴアイン',
      )
      sweepfeet.sire = Horse.generate_stub(name: 'スワーヴリチャード', sex: :male, foaled: '2014/03/10')
      sweepfeet.dam = Horse.generate_stub(name: 'ビジュートウショウ', sex: :female, foaled: '2011/02/25')
      sweepfeet.save

      rb.win(horse: sweepfeet, date: '2024/03/02', race_name: 'チューリップ賞', code: :jra_g2)

      rb.build_family(
        bloodmare: 'セヴアイン',
        family_number: 'F5-j',
        imported_by: '東北牧場',
        imported_at: '1929',
        only_year: true,
        foaled: '1921',
        foaled_only_year: true,
        from: :America,
      )
    end
  end

  def down
    ActiveRecord::Base.transaction do
      sweepfeet = Horse.find_by(name: 'スウィープフィート')
      family_line = sweepfeet&.family_line
      sevign = family_line&.imported_mare

      sweepfeet&.destroy
      family_line&.destroy
      sevign&.destroy
    end
  end
end
