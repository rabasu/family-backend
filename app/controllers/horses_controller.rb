class HorsesController < ApplicationController
  # race_horseの馬を一覧表示
  def index
    @horses = Horse.where(group: :race_horse)
    json_string = HorseSerializer.new(@horses, options).serializable_hash.to_json

    # api/json下にjsonファイルを作成しjson_stringを書き込む
    File.write('../api/json/horses.json', json_string)

    render json: json_string
  end

  # race_horseの馬を個別表示
  def show
    @horse = Horse.find(params[:id])
    json_string = HorseSerializer.new(@horse).serializable_hash.to_json
    render json: json_string
  end

  private

  def options
    { fields: { horse: %i[display_name foaled sex group sire dam won_races all_races family_line] } }
  end
end
