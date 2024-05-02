class FamilyLinesController < ApplicationController
  # 牝系を一覧表示
  def index
    @family_lines = FamilyLine.all
    json_string = FamilyLineSerializer.new(@family_lines, options).serializable_hash.to_json

    # api/json下にjsonファイルを作成しjson_stringを書き込む
    File.write('../api/json/family_lines.json', json_string)

    render json: json_string
  end

  # 牝系を個別表示
  def show
    @family_line = FamilyLine.find(params[:id])
    json_string = FamilyLineSerializer.new(@family_line, options).serializable_hash.to_json
    render json: json_string
  end

  private

  def options
    { fields: { family_line: %i[display_name family_number imported_year imported_by bloodmare horses] } }
  end
end
