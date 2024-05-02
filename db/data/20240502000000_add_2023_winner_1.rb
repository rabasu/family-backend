# frozen_string_literal: true

class Add2023Winner1 < ActiveRecord::Migration[7.1]
  def up
    ActiveRecord::Base.transaction do
      rb = RecordBuilder.new
      # セイウンハーデス
      seiun_hades = rb.build(
        name: 'セイウンハーデス',
        foaled: '2019/04/08',
        sex: :male,
        group: :race_horse,
        family_line: 'フロリースカツプ',
      )
      seiun_hades.sire = Horse.generate_stub(name: 'シルバーステート', sex: :male, foaled: '2013/05/02')
      seiun_hades.dam = Horse.generate_stub(name: 'ハイノリッジ', sex: :female, foaled: '2011/03/31')
      seiun_hades.save

      rb.run(horse: seiun_hades, date: '2023/07/09', race_name: '七夕賞', grade: :jra_g3, finnish: 1)
      rb.run(horse: seiun_hades, date: '2023/05/07', race_name: '新潟大賞典', grade: :jra_g3, finnish: 2)

      rb.build_family(
        bloodmare: 'フロリースカツプ',
        family_number: 'F3-l',
        imported_by: '小岩井農場',
        imported_at: '1907',
        only_year: true,
        foaled: '1904',
        foaled_only_year: true,
        from: :England,
      )

      # キタウイング
      kita_wing = rb.build(
        name: 'キタウイング',
        foaled: '2020/05/14',
        sex: :female,
        group: :race_horse,
        family_line: '種道',
      )
      kita_wing.sire = Horse.generate_stub(name: 'ダノンバラード', sex: :male, foaled: '2008/02/19')
      kita_wing.dam = Horse.generate_stub(name: 'キタノリツメイ', sex: :female, foaled: '2014/04/04')
      kita_wing.save

      rb.run(horse: kita_wing, date: '2022/08/28', race_name: '新潟2歳ステークス', grade: :jra_g3, finnish: 1)
      rb.run(horse: kita_wing, date: '2023/01/09', race_name: 'フェアリーステークス', grade: :jra_g3, finnish: 1)

      rb.build_family(
        bloodmare: '種道',
        racing_name: 'Helenagain',
        family_number: 'F22',
        imported_by: '下総御料牧場',
        imported_at: '1926',
        only_year: true,
        foaled: '1922',
        foaled_only_year: true,
        from: :England,
      )

      # ノースブリッジ
      north_bridge = rb.build(
        name: 'ノースブリッジ',
        foaled: '2018/01/24',
        sex: :male,
        group: :race_horse,
        family_line: 'セレタ',
      )
      north_bridge.sire = Horse.generate_stub(name: 'モーリス', sex: :male, foaled: '2011/03/02')
      north_bridge.dam = Horse.generate_stub(name: 'アメージングムーン', sex: :female, foaled: '2010/04/10')
      north_bridge.save

      rb.run(horse: north_bridge, date: '2021/07/04', race_name: 'ラジオNIKKEI賞', grade: :jra_g3, finnish: 3)
      rb.run(horse: north_bridge, date: '2022/06/12', race_name: 'エプソムカップ', grade: :jra_g3, finnish: 1)
      rb.run(horse: north_bridge, date: '2023/01/22', race_name: 'アメリカジョッキークラブカップ', grade: :jra_g2, finnish: 1)

      GradedRace.create(
        code: :hk_qe2c,
        name: 'クイーンエリザベス2世C',
        official_name: 'クイーンエリザベス2世カップ',
        desc: '香港GI',
        breed: :thoroughbred,
        status: :current,
        grade: Grade.find_by(code: :abroad_g1),
      )

      rb.run(horse: north_bridge, date: '2024/04/28', race_name: 'クイーンエリザベス2世カップ', grade: :abroad_g1, finnish: 3)

      rb.build_family(
        bloodmare: 'セレタ',
        family_number: 'F4-r',
        imported_by: '羽田牧場',
        imported_at: '1929',
        only_year: true,
        foaled: '1919',
        foaled_only_year: true,
        from: :Ireland,
      )

      # ナミュール
      namur = rb.build(
        name: 'ナミュール',
        foaled: '2019/03/02',
        sex: :female,
        group: :race_horse,
        family_line: 'シユリリー',
      )
      namur.sire = Horse.generate_stub(name: 'ハービンジャー', sex: :male, foaled: '2006/03/12')
      namur.dam = Horse.generate_stub(name: 'サンブルエミューズ', sex: :female, foaled: '2010/01/23')
      namur.save

      rb.run(horse: namur, date: '2022/03/05', race_name: 'チューリップ賞', grade: :jra_g2, finnish: 1)
      rb.run(horse: namur, date: '2022/05/22', race_name: '優駿牝馬（オークス）', grade: :jra_g1, finnish: 3)
      rb.run(horse: namur, date: '2022/10/16', race_name: '秋華賞', grade: :jra_g1, finnish: 2)
      rb.run(horse: namur, date: '2023/02/05', race_name: '東京新聞杯', grade: :jra_g3, finnish: 2)
      rb.run(horse: namur, date: '2023/10/21', race_name: '富士ステークス', grade: :jra_g2, finnish: 1)
      rb.run(horse: namur, date: '2023/11/19', race_name: 'マイルチャンピオンシップ', grade: :jra_g1, finnish: 1)


      GradedRace.create(
        code: :hk_mile,
        name: '香港マイル',
        official_name: '香港マイル',
        desc: '香港GI',
        breed: :thoroughbred,
        status: :current,
        grade: Grade.find_by(code: :abroad_g1),
      )

      GradedRace.create(
        code: :db_turf,
        name: 'ドバイターフ',
        official_name: 'ドバイターフ',
        desc: 'ドバイGI',
        breed: :thoroughbred,
        status: :current,
        grade: Grade.find_by(code: :abroad_g1),
      )

      rb.run(horse: namur, date: '2023/12/10', race_name: '香港マイル', grade: :abroad_g1, finnish: 3)
      rb.run(horse: namur, date: '2024/03/30', race_name: 'ドバイターフ', grade: :abroad_g1, finnish: 2)

      rb.build_family(
        bloodmare: 'シユリリー',
        family_number: 'F7-d',
        imported_by: '渋谷平乗',
        imported_at: '1930',
        only_year: true,
        foaled: '1925',
        foaled_only_year: true,
        from: :Australia,
      )
    end
  end

  def down
    ActiveRecord::Base.transaction do
      horses = %w[セイウンハーデス キタウイング ノースブリッジ ナミュール]
      horses.each do |h|
        t = Horse.find_by(name: h)
        t&.bloodmare&.destroy
        t&.destroy
      end
    end
  end
end
